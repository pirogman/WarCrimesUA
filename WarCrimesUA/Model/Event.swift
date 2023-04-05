//
//  Event.swift
//  CrimesUA
//

import Foundation

struct Event: Identifiable {
    let id: String
    let from, till: String // In "yyyy-MM-dd" format
    let lat, lon: Double
    let eventTypes: [String]?
    let qualifications: [String]?
    let objectStatus: [String]?
    let affectedTypes: [String]?
    let affectedNumbers: [Int]?
    
    init?(id: String, value: [String: Any]?) {
        guard let value = value else { return nil }
        
        self.id = id
        
        guard let from = value["from"] as? String,
              let till = value["till"] as? String,
              let lat = value["lat"] as? Double,
              let lon = value["lon"] as? Double
        else { return nil }
        
        self.from = from
        self.till = till
        self.lat = lat
        self.lon = lon
        
        self.eventTypes = value["event"] as? [String]
        self.qualifications = value["qualification"] as? [String]
        self.objectStatus = value["object_status"] as? [String]
        self.affectedTypes = value["affected_types"] as? [String]
        self.affectedNumbers = value["affected_numbers"] as? [Int]
    }
}
