//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Данил Шипицын on 11.10.2023.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.data)
        }
    }
}
