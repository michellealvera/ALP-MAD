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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    try? realm.write {
                        let onboarding = realm.object(ofType: Preference.self, forPrimaryKey: "hasFinishedOnboarding")
                        let username = realm.object(ofType: Preference.self, forPrimaryKey: "username")
                        
                        if onboarding == nil {
                            let newOnboarding = Preference()
                            newOnboarding.key = "hasFinishedOnboarding"
                            newOnboarding.value = "false"
                            realm.add(newOnboarding)
                        }
                        
                        if username == nil {
                            let newUsername = Preference()
                            newUsername.key = "username"
                            newUsername.value = ""
                            realm.add(newUsername)
                        }
                        
                    }
                }
               
        }
    }
}
