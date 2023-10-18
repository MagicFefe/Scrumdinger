//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Данил Шипицын on 11.10.2023.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error,
                                                    guidance: "Scrumdinger will load sample data and continue.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error,
                                                guidance: "Try again later.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.scrums = DailyScrum.data
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
