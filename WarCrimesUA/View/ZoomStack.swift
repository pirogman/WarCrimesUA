//
//  ZoomStack.swift
//  CrimesUA
//

import SwiftUI

struct ZoomStack: View {
    @ObservedObject var viewModel: CrimesMapViewModel
    
    private let spacing: CGFloat = 8
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            HStack(spacing: spacing) {
                Image(systemName: "magnifyingglass")
                    .resizable().scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.primary)
                ForEach([MapPoint.ukraine, .kyiv, .mariupol]) { point in
                    ZoomButton(title: point.title(with: viewModel.language)) {
                        viewModel.mapPoint = point
                    }
                }
            }
            HStack(spacing: spacing) {
                ForEach([MapPoint.izyum, .kharkiv, .chernihiv]) { point in
                    ZoomButton(title: point.title(with: viewModel.language)) {
                        viewModel.mapPoint = point
                    }
                }
            }
            HStack(spacing: spacing) {
                ForEach([MapPoint.kherson, .mykolaiv]) { point in
                    ZoomButton(title: point.title(with: viewModel.language)) {
                        viewModel.mapPoint = point
                    }
                }
            }
        }
    }
}
