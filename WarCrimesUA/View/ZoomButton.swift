//
//  ZoomButton.swift
//  CrimesUA
//

import SwiftUI

struct ZoomButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button { action() } label: {
            Text(title)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .strokeBorder(Color.accentColor)
                )
        }
    }
}
