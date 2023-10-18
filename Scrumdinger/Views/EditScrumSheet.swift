//
//  EditScrumSheet.swift
//  Scrumdinger
//
//  Created by Данил Шипицын on 18.10.2023.
//

import SwiftUI

struct EditScrumSheet: View {
    
    @Binding var scrum: DailyScrum
    @Binding var editScrum: DailyScrum
    @Binding var isPresentingEditSheet: Bool
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $editScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingEditSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            scrum = editScrum
                            isPresentingEditSheet = false
                        }
                    }
                }
        }
    }
}

#Preview {
    EditScrumSheet(scrum: .constant(DailyScrum.emptyScrum), editScrum: .constant(DailyScrum.emptyScrum), isPresentingEditSheet: .constant(true))
}
