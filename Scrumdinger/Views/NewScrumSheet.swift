//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by Данил Шипицын on 17.10.2023.
//

import SwiftUI

struct NewScrumSheet: View {
    @Binding var isPresentingNewScrumView: Bool
    @Binding var scrums: [DailyScrum]
    @State private var newScrum = DailyScrum.emptyScrum
    
    private var newScrumIsValid: Bool {
        !newScrum.attendees.isEmpty && !newScrum.title.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            guard newScrumIsValid else { return }
                            scrums.append(newScrum)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}

#Preview {
    NewScrumSheet(isPresentingNewScrumView: .constant(true), scrums: .constant([]))
}
