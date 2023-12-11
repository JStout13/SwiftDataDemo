//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by Jason Stout on 12/9/23.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataDemoApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Video.self, Keyword.self, migrationPlan: DatabaseMigrationPlan.self)
        } catch {
            fatalError("Failed to initialize model container")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                VideosView()
            }
        }
        .modelContainer(container)
    }
}
