//
//  LanguageManager.swift
//  CrimesUA
//

import Foundation

class LanguageManager {
    static func from(_ language: EventDescription.Language) -> String {
        switch language {
        case .ua: return "З:"
        default: return "From:"
        }
    }
    static func till(_ language: EventDescription.Language) -> String {
        switch language {
        case .ua: return "По:"
        default: return "Till:"
        }
    }
    static func crimes(_ language: EventDescription.Language) -> String {
        switch language {
        case .ua: return " вчинених злочинів в обраний період."
        default: return " committed crimes in selected time period."
        }
    }
}
