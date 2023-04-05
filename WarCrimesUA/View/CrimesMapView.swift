//
//  CrimesMapView.swift
//  CrimesUA
//

import SwiftUI
import MapKit

struct CrimesMapView: View {
    @StateObject var viewModel = CrimesMapViewModel()
    
    @State var selectedCluster: EventCluster?
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.clusters) { cluster in
            MapAnnotation(
                coordinate: cluster.coordinate,
                anchorPoint: CGPoint(x: 0.5, y: 0.5)
            ) {
                EventClusterView(cluster, selectedCluster: $selectedCluster)
            }
        }
        .ignoresSafeArea()
        .overlay(
            MapDetailsView(viewModel: viewModel)
                .padding(.all, 12)
            , alignment: .topLeading
        )
        .onChange(of: viewModel.clusters) { newValue in
            // Deselect cluster if needed
            guard let id = selectedCluster?.id else { return }
            if !newValue.contains(where: { $0.id == id }) {
                withAnimation { selectedCluster = nil }
            }
        }
    }
}

private struct LanguageEnvironmentKey: EnvironmentKey {
    static let defaultValue: EventDescription.Language = .en
}

extension EnvironmentValues {
    var language: EventDescription.Language {
        get { self[LanguageEnvironmentKey.self] }
        set { self[LanguageEnvironmentKey.self] = newValue }
    }
}
