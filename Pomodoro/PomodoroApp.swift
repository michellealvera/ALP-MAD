//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import SwiftUI

@main
struct PomodoroApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
