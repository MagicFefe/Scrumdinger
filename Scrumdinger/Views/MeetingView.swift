//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Данил Шипицын on 11.10.2023.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    @Binding var scrum: DailyScrum
    
    @State private var isRecording: Bool = false
    
    private var player: AVPlayer {
        AVPlayer.sharedDingPlayer
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                MeetingTimerView(speakers: scrumTimer.speakers, isRecording: isRecording, theme: scrum.theme)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
            .padding()
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear(perform: startScrum)
        .onDisappear(perform: stopScrum)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        scrumTimer.startScrum()
    }
    
    private func stopScrum() {
        scrumTimer.stopScrum()
        speechRecognizer.stopTranscribing()
        isRecording = false
        let history = History(attendees: scrum.attendees,
                              transcript: speechRecognizer.transcript)
        scrum.history.insert(history, at: 0)
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.emptyScrum))
}
