//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Данил Шипицын on 13.10.2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var isPresentingEditView: Bool = false
    @State private var editingScrum: DailyScrum = DailyScrum.emptyScrum
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                    
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Attendies")) {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("History")) {
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                } else {
                    ForEach(scrum.history) { history in
                        NavigationLink(destination: HistoryView(history: history)) {
                            HStack {
                                Image(systemName: "calendar")
                                Text(history.date, style: .date)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                editingScrum = scrum
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            EditScrumSheet(scrum: $scrum, editScrum: $editingScrum, isPresentingEditSheet: $isPresentingEditView)
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(scrum: .constant(DailyScrum.data[0]))
    }
}
