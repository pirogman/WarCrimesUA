//
//  EventClusterBubbleView.swift
//  CrimesUA
//

import SwiftUI

struct EventClusterBubbleView: View {
    let count: Int
    
    init(_ cluster: EventCluster) {
        self.count = cluster.count
    }
    
    var body: some View {
        Circle()
            .foregroundColor(.accentColor)
            .frame(width: pinSize, height: pinSize)
            .overlay(
                Text("\(count)")
                    .foregroundColor(.white)
                    .bold()
            )
    }
    
    var pinSize: CGFloat {
        switch count {
        case 1_000...: return 120
        case 100...: return 80
        case 10...: return 60
        case 2...9: return 44
        default: return 32
        }
    }
}
