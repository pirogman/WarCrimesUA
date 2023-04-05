//
//  DetailedEvent.swift
//  CrimesUA
//

import Foundation

struct DetailedEvent: Identifiable {
    let id: String
    let lat, lon: Double
    let from, till: Date
    let eventTypes: [String]?
    let qualifications: [String]?
    let objectStatus: [String]?
    let affectedTypes: [String]?
    let affectedNumbers: Int?
    
    init(event: Event, description: EventDescription) {
        self.id = event.id
        self.lat = event.lat
        self.lon = event.lon
        self.from = DateFormatter.crime.date(from: event.from)!
        self.till = DateFormatter.crime.date(from: event.till)!
        
        self.eventTypes = event.eventTypes?.compactMap { description.eventTypes[$0] }
        self.qualifications = event.qualifications?.compactMap { description.qualifications[$0] }
        self.objectStatus = event.objectStatus?.compactMap { description.objectStatus[$0] }
        self.affectedTypes = event.affectedTypes?.compactMap { description.affectedTypes[$0] }
        self.affectedNumbers = event.affectedNumbers?.compactMap { $0 }.reduce(0, +)
    }
}
