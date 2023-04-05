//
//  EventDescription.swift
//  CrimesUA
//

import Foundation

struct EventDescription {
    // Available languages for description localisation
    enum Language: String, CaseIterable {
        case ua, de, en, fr, es, it, ru
    }
    
    // Values can be an empty string ""
    let affectedTypes: [String: String]
    let objectStatus: [String: String]
    let eventTypes: [String: String]
    let qualifications: [String: String]
    
    init?(value: [String: Any]?) {
        guard let affectedTypes = value?["affected_type"] as? [String: String],
              let objectStatus = value?["object_status"] as? [String: String],
              let eventTypes = value?["event"] as? [String: String],
              let qualifications = value?["qualification"] as? [String: String]
        else { return nil }
        
        self.affectedTypes = affectedTypes
        self.objectStatus = objectStatus
        self.eventTypes = eventTypes
        self.qualifications = qualifications
    }
}
