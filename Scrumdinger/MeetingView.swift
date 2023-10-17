//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Данил Шипицын on 11.10.2023.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        VStack {
            // 5/15
            ProgressView(value: 30, total: 100)
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds ellapsed")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.bottomhalf.fill")
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Time remaining")
            .accessibilityValue("10 minutes")
            Circle()
                .strokeBorder(lineWidth: 24)
            HStack {
                Text("Speaker 1 of 3")
                Spacer()
                Button(action: {}) {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel("Next speaker")
            }
            
        }
        .padding()
    }
}

#Preview {
    MeetingView()
}
