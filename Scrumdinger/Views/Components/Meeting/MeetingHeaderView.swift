//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Данил Шипицын on 17.10.2023.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
    private var secondsTotal: Int {
        secondsElapsed + secondsRemaining
    }
    
    private var progress: Double {
        guard secondsTotal > 0 else { return 1 }
        return Double(secondsElapsed) / Double(secondsTotal)
    }
    
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds ellapsed")
                        .font(.caption)
                    Label(String(secondsElapsed), systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds remaining")
                        .font(.caption)
                    Label(String(secondsRemaining), systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])
    }
}

#Preview {
    MeetingHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .bubblegum)
        .previewLayout(.sizeThatFits)
}
