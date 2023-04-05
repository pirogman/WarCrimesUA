//
//  EventClusterDetailsView.swift
//  CrimesUA
//

import SwiftUI

struct EventClusterDetailsView: View {
    let interval: DateInterval
    let eventTypes: [String: Int]
    
    init(_ cluster: EventCluster) {
        self.interval = cluster.timeInterval
        self.eventTypes = cluster.eventTypes
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 0) {
                    Image(systemName: "calendar")
                        .resizable().scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.primary)
                        .padding(.trailing, 6)
                    Text("\(DateFormatter.crime.string(from: interval.start))")
                    if interval.duration >= .day {
                        Text(" - \(DateFormatter.crime.string(from: interval.end))")
                    }
                }
                Divider()
            }
            if !eventTypes.isEmpty {
                let sorted = Array(eventTypes.keys)
                    .sorted(by: { k1, k2 in
                        let v1 = eventTypes[k1]!
                        let v2 = eventTypes[k2]!
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
                        Text("\(eventTypes[type]!)").bold() + Text(" - \(type)")
                    }
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .frame(width: 240)
        .padding(.all, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .tertiarySystemBackground))
        )
    }
}
