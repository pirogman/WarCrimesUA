//
//  EventClusterView.swift
//  CrimesUA
//

import SwiftUI

struct EventClusterView: View {
    let cluster: EventCluster
    
    @Binding var selectedCluster: EventCluster?
    
    init(_ cluster: EventCluster, selectedCluster: Binding<EventCluster?>) {
        self.cluster = cluster
        self._selectedCluster = selectedCluster
    }
    
    var body: some View {
        if let selected = selectedCluster {
            if cluster.id == selected.id {
                EventClusterDetailsView(cluster)
                    .transition(.scale)
                    .onTapGesture {
                        withAnimation { selectedCluster = nil }
                    }
            } else {
                EmptyView()
            }
        } else {
            EventClusterBubbleView(cluster)
                .transition(.scale)
                .onTapGesture {
                    withAnimation { selectedCluster = cluster }
                }
        }
    }
}
