//
//  Extensions.swift
//  CrimesUA
//

import Foundation

extension DateFormatter {
    static let crime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

extension Date {
    static let invasion = Calendar.current.date(from: DateComponents(year: 2022, month: 2, day: 24))!
    static let today = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Date()))!
    
    func shiftDay(_ count: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: count, to: self)!
    }
}

extension TimeInterval {
    static let minute: TimeInterval = 60
    static let hour = minute * 60
    static let day = hour * 24
}
