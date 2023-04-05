//
//  LanguageButton.swift
//  CrimesUA
//

import SwiftUI

struct LanguageButton: View {
    let language: EventDescription.Language
    
    var isSelected: Bool {
        language == selected
    }
    
    @Binding var selected: EventDescription.Language
    
    init(_ language: EventDescription.Language, selected: Binding<EventDescription.Language>) {
        self.language = language
        self._selected = selected
    }
    
    var body: some View {
        Button {
            withAnimation { selected = language }
        } label: {
            Text(language.rawValue.uppercased())
                .foregroundColor(isSelected ? .white : .accentColor)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(
                    ZStack {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(isSelected ? Color.accentColor : .clear)
                        } else {
                            RoundedRectangle(cornerRadius: 4)
                                .strokeBorder(isSelected ? Color.clear : .accentColor)
                        }
                    }
                )
        }
    }
}
