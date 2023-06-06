//
//  StateObject.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 06/06/23.
//

import Foundation
import RealmSwift

class Env: ObservableObject {
    @Published var username: String = ""
    @Published var onboarding: Bool = false
    
    func initData(realm: Realm) -> Void {
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
            
            self.username = username!.value
            self.onboarding = Bool(onboarding!.value) ?? false
        }
    }
}
