//
//  iTourApp.swift
//  iTour
//
//  Created by Kevin Pfefferle on 10/9/23.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
