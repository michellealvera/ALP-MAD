//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import SwiftUI

@main
struct PomodoroApp: App {
   
    @Environment(\.realm) var realm
    @StateObject var env: Env = Env()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(env)
                .onAppear {
                    env.initData(realm: realm)
                }
               
        }
    }
}
