//
//  EventCluster.swift
//  CrimesUA
//

import Foundation
import MapKit

struct EventCluster: Identifiable {
    let events: [DetailedEvent]
    let id: String
    let count: Int
    let lat, lon: Double
    
    var timeInterval: DateInterval {
        let start = events.sorted { $0.from < $1.from }.first!.from
        let end = events.sorted { $0.till > $1.till }.first!.till
        return DateInterval(start: start, end: end)
    }
    
    var eventTypes: [String: Int] {
        var result = [String: Int]()
        for e in events {
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
    
    init(_ events: [DetailedEvent]) {
        let first = events.first!
        self.id = first.id
        self.lat = first.lat
        self.lon = first.lon
        self.count = events.count
        self.events = events
    }
}

extension EventCluster: Equatable {
    static func == (lhs: EventCluster, rhs: EventCluster) -> Bool {
        lhs.id == rhs.id && lhs.count == rhs.count
    }
}
