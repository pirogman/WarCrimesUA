//
//  MapPoint.swift
//  CrimesUA
//

import Foundation
import MapKit

struct MapPoint: Identifiable {
    let id: String
    let coordinate: CLLocationCoordinate2D
    let distance: CLLocationDistance // in meters
    
    init(_ id: String, lat: Double, lon: Double, m: Int) {
        self.id = id
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.distance = CLLocationDistance(m)
    }
    
    func title(with language: EventDescription.Language) -> String {
        switch id {
        case "Ukraine":
            switch language {
            case .ua: return "Україна"
            default: return id
            }
            
        case "Kyiv":
            switch language {
            case .ua: return "Київ"
            default: return id
            }
            
        case "Kharkiv":
            switch language {
            case .ua: return "Харків"
            default: return id
            }
            
        case "Chernihiv":
            switch language {
            case .ua: return "Чернігів"
            default: return id
            }
            
        case "Mykolaiv":
            switch language {
            case .ua: return "Миколаїв"
            default: return id
            }
            
        case "Kherson":
            switch language {
            case .ua: return "Херсон"
            default: return id
            }
            
        case "Mariupol":
            switch language {
            case .ua: return "Маріуполь"
            default: return id
            }
            
        case "Izyum":
            switch language {
            case .ua: return "Ізюм"
            default: return id
            }
            
        default:
            return id
        }
    }
    
    static let ukraine = MapPoint("Ukraine", lat: 48.3794, lon: 31.1656, m: 1_000_000)
    static let kyiv = MapPoint("Kyiv", lat: 50.4501, lon: 30.5234, m: 20_000)
    static let kharkiv = MapPoint("Kharkiv", lat: 49.9935, lon: 36.2304, m: 16_000)
    static let chernihiv = MapPoint("Chernihiv", lat: 51.4982, lon: 31.2893, m: 16_000)
    static let mykolaiv = MapPoint("Mykolaiv", lat: 46.9750, lon: 31.9946, m: 16_000)
    static let kherson = MapPoint("Kherson", lat: 46.6354, lon: 32.6169, m: 16_000)
    static let mariupol = MapPoint("Mariupol", lat: 47.0971, lon: 37.5434, m: 12_000)
    static let izyum = MapPoint("Izyum", lat: 49.2121, lon: 37.2665, m: 6_000)
}

extension MKCoordinateRegion {
    init(mapPoint: MapPoint) {
        self.init(center: mapPoint.coordinate, latitudinalMeters: mapPoint.distance, longitudinalMeters: mapPoint.distance)
    }
}
