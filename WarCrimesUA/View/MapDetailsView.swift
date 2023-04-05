//
//  MapDetailsView.swift
//  CrimesUA
//

import SwiftUI

struct MapDetailsView: View {
    @ObservedObject var viewModel: CrimesMapViewModel
    
    @State var isOpen = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if isOpen {
                HStack {
                    Image(systemName: "xmark")
                        .resizable().scaledToFit()
                        .padding(.all, 4)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.accentColor)
                        .onTapGesture {
                            withAnimation { isOpen = false }
                        }
                        .transition(.scale)
                        .animation(.spring(), value: isOpen)
                    Spacer()
                    HStack {
                        ForEach([EventDescription.Language.en, .ua], id: \.self) { language in
                            LanguageButton(language, selected: $viewModel.language)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    DateIntervalView($viewModel.interval, range: viewModel.allowedRange, stackHorizontally: false)
                        .environment(\.language, viewModel.language)
                    Group {
                        Text("\(viewModel.intervalEvents.count)").bold().underline() + Text(LanguageManager.crimes(viewModel.language))
                    }
                    .padding(.vertical, 4)
                    let types = viewModel.eventTypes
                    if !types.isEmpty {
                        VStack(alignment: .leading) {
                            let sorted = Array(types.keys)
                                .sorted(by: { k1, k2 in
                                    let v1 = types[k1]!
                                    let v2 = types[k2]!
                                    if v1 > v2 {
                                        return true
                                    } else if v1 < v2 {
                                        return false
                                    } else {
                                        return k1 < k2
                                    }
                                })
                            ForEach(sorted, id: \.self) { type in
                                Group {
                                    Text("\(types[type]!)").bold() + Text(" - \(type)")
                                }
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        .padding(.bottom, 4)
                    }
                    ZoomStack(viewModel: viewModel)
                }
                // Delay showing fields until background is stretched enough
                .animation(.spring().delay(isOpen ? 0.6 : 0), value: isOpen)
            } else {
                Image(systemName: "info.circle")
                    .resizable().scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        withAnimation { isOpen = true }
                    }
                    .transition(.scale)
                    .animation(.spring(), value: isOpen)
            }
        }
        .padding()
        .frame(width: isOpen ? 300 : nil)
        .padding(.all, 6)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .tertiarySystemBackground))
                // Delay background squishing for fields to hide first
                .animation(.spring().delay(isOpen ? 0 : 0.3), value: isOpen)
        )
    }
}
