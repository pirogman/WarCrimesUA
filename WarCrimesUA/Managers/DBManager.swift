//
//  DBManager.swift
//  CrimesUA
//

import Foundation

class DBManager {
    static let shared = DBManager()
    private init() { }
    
    // MARK: - Loading from local DB
    
    func loadEvents(completion: @escaping ([Event]) -> Void) {
        // Do it off main queue as in may take some time
        DispatchQueue.global(qos: .userInitiated).async {
            let data = DBManager.loadJSON(fileName: "event")!
            let json = DBManager.serializeJSON(from: data)!
            let rowEvents = DBManager.parseEvents(from: json)
            let sortedEvents = rowEvents.sorted { $0.id < $1.id }
            
            DispatchQueue.main.async {
                completion(sortedEvents)
            }
        }
    }
    
    func loadDescriptions(completion: @escaping ([String: EventDescription]) -> Void) {
        // Do it off main queue as in may take some time
        DispatchQueue.global(qos: .userInitiated).async {
            let data = DBManager.loadJSON(fileName: "names")!
            let json = DBManager.serializeJSON(from: data)!
            let descriptions = DBManager.parseDescriptions(from: json)
            
            DispatchQueue.main.async {
                completion(descriptions)
            }
        }
    }
    
    // MARK: - Helpers
    
    static private func parseEvents(from json: [String: Any]) -> [Event] {
        json.compactMap { Event(id: $0.key, value: $0.value as? [String: Any]) }
    }
    
    static private func parseDescriptions(from json: [String: Any]) -> [String: EventDescription] {
        json.compactMapValues { EventDescription(value: $0 as? [String: Any]) }
    }
    
    static private func serializeJSON(from data: Data) -> [String: Any]? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            return jsonObject as? [String: Any]
        } catch let error {
            print("Serialization error: \(error)")
            return nil
        }
    }
    
    static private func loadJSON(fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print("No such file...")
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return jsonData
        } catch let error {
            print("Loading error: \(error)")
            return nil
        }
    }
}
