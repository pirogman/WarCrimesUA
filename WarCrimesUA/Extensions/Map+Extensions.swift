//
//  Map+Extensions.swift
//  CrimesUA
//

import MapKit

extension Event {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
    }
}

extension DetailedEvent {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
    }
}

extension EventCluster {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
    }
}

extension CLLocationCoordinate2D {
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let destination = CLLocation(latitude: from.latitude, longitude: from.longitude)
        return CLLocation(latitude: latitude, longitude: longitude).distance(from: destination)
    }
}

extension MKCoordinateSpan {
    var visibleDistance: Double {
        // Get maximum from lat and lon degrees for different
        // orientations, then multiply by default 111km to get
        // whole range of map on screen and take half (radius)
        return max(self.latitudeDelta, self.longitudeDelta) * 111_000 / 2
    }
    var clusteringDistance: Double {
        // Get minimum from lat and lon degrees for different
        // orientations, then multiply by default 111km to get
        // whole range and use some of that as clustering distance
        return min(self.latitudeDelta, self.longitudeDelta) * 111_000 / 7
    }
}

// MARK: - Equatable

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension MKCoordinateSpan: Equatable {
    public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }
}

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center == rhs.center && lhs.span == rhs.span
    }
}
