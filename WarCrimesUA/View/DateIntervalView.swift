//
//  DateIntervalView.swift
//  CrimesUA
//

import SwiftUI

struct DateIntervalView: View {
    @Environment(\.language) var language: EventDescription.Language
    
    @State private var startDate: Date
    @State private var endDate: Date
    
    var startRange: ClosedRange<Date> {
        let end = min(endDate, range.upperBound)
        return range.lowerBound...end
    }
    var endRange: ClosedRange<Date> {
        let start = max(startDate, range.lowerBound)
        return start...range.upperBound
    }
    
    @Binding var interval: DateInterval
    
    let range: ClosedRange<Date>
    let stackHorizontally: Bool
    
    init(_ interval: Binding<DateInterval>, range: ClosedRange<Date>, stackHorizontally: Bool) {
        self.range = range
        self.stackHorizontally = stackHorizontally
        self._interval = interval
        self._startDate = State(wrappedValue: interval.wrappedValue.start)
        self._endDate = State(wrappedValue: interval.wrappedValue.end)
    }
    
    var body: some View {
        if stackHorizontally {
            HStack {
                fromPicker
                tillPicker
            }
        } else {
            VStack {
                fromPicker
                tillPicker
            }
        }
    }
    
    private var fromPicker: some View {
        DatePicker(selection: $startDate, in: startRange, displayedComponents: .date) {
            Text(LanguageManager.from(language))
        }
        .datePickerStyle(.compact)
        .onChange(of: startDate) { newValue in
            interval = DateInterval(start: startDate, end: endDate)
        }
    }
    
    private var tillPicker: some View {
        DatePicker(selection: $endDate, in: endRange, displayedComponents: .date) {
            Text(LanguageManager.till(language))
        }
        .datePickerStyle(.compact)
        .onChange(of: endDate) { newValue in
            interval = DateInterval(start: startDate, end: endDate)
        }
    }
}
