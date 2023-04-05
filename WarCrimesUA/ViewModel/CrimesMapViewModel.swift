//
//  CrimesMapViewModel.swift
//  CrimesUA
//

import Foundation
import Combine
import MapKit

class CrimesMapViewModel: ObservableObject {
    let allowedRange = Date.invasion...Date.today
    
    // Public publishers for users to interact with
    @Published var mapPoint: MapPoint
    @Published var language: EventDescription.Language
    @Published var interval: DateInterval
    @Published var region: MKCoordinateRegion
    
    // Output publishers
    @Published private(set) var languageDescription: EventDescription?
    @Published private(set) var intervalEvents = [DetailedEvent]()
    @Published private(set) var clusters = [EventCluster]()
    
    // Row internal data
    @Published private var events = [Event]()
    @Published private var eventDescriptions = [String: EventDescription]()
        
    init(mapPoint: MapPoint = .ukraine,
         language: EventDescription.Language = .en,
         interval: DateInterval = DateInterval(start: Date.today.shift(days: -7), end: Date.today)
    ) {
        self.mapPoint = mapPoint
        self.language = language
        self.interval = interval
        self.region = MKCoordinateRegion(mapPoint: mapPoint)
        
        // Update region on map point changes
        $mapPoint
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .map { MKCoordinateRegion(mapPoint: $0) }
            .assign(to: \.region, on: self)
            .store(in: &cancelableSet)
        
        // Update event description on language changes
        // or when initial event descriptions are loaded
        Publishers
            .CombineLatest($language, $eventDescriptions)
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .map { newLanguage, allDescriptions in
                return allDescriptions[newLanguage.rawValue]
            }
            .assign(to: \.languageDescription, on: self)
            .store(in: &cancelableSet)
        
        // Update interval events on start/end dates changes,
        // new description selected or when initial events are loaded
        Publishers
            .CombineLatest3($interval, $languageDescription, $events)
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .map { newInterval, selectedDescription, allEvents in
                guard let description = selectedDescription else { return [] }
                return allEvents.filter { event in
                    let from = DateFormatter.crime.date(from: event.from)!
                    let till = DateFormatter.crime.date(from: event.till)!
                    return newInterval.contains(from) || newInterval.contains(till)
                }
                .map { DetailedEvent(event: $0, description: description) }
            }
            .assign(to: \.intervalEvents, on: self)
            .store(in: &cancelableSet)
        
        // Update clusters when interval changes or region changes
        Publishers
            .CombineLatest($intervalEvents, $region)
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .map { newEvents, newRegion in
                // Filter out events that are off map
                let includeDistance = newRegion.span.visibleDistance
                let visibleEvents = newEvents.filter { $0.coordinate.distance(from: newRegion.center) < includeDistance }
                
                // Cluster visible events
                let clusterDistance = newRegion.span.clusteringDistance
                var clusters = [EventCluster]()
                for event in visibleEvents {
                    if let index = clusters.firstIndex(where: { $0.coordinate.distance(from: event.coordinate) < clusterDistance }) {
                        let newEvents = clusters[index].events + [event]
                        clusters[index] = EventCluster(newEvents)
                    } else {
                        clusters.append(EventCluster([event]))
                    }
                }
                
                return clusters
            }
            .receive(on: RunLoop.main)
            .assign(to: \.clusters, on: self)
            .store(in: &cancelableSet)
        
        // Load events and descriptions from local JSON files
        DBManager.shared.loadDescriptions { [weak self] result in
            self?.eventDescriptions = result
        }
        DBManager.shared.loadEvents { [weak self] result in
            self?.events = result
        }
    }
    
    private var cancelableSet = Set<AnyCancellable>()
    
    deinit {
        cancelableSet.removeAll()
    }
    
    var eventTypes: [String: Int] {
        var result = [String: Int]()
        for e in intervalEvents {
            guard let types = e.eventTypes else { continue }
            for t in types.filter({ !$0.isEmpty }) {
                if let count = result[t] {
                    result[t] = count + 1
                } else {
                    result[t] = 1
                }
            }
        }
        return result
    }
}
