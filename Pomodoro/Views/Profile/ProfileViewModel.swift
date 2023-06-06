//
//  ProfileViewModel.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 04/06/23.
//

import Foundation
import SwiftUI
import RealmSwift

extension ProfileView {
    class ViewModel: ObservableObject {
        @Published var isEditingName = false
        @Published var changeUsernameText = ""
        
        func editName(realm: Realm) -> Void {
            
            if isEditingName && !changeUsernameText.isEmpty {
                try? realm.write {
                    let username = realm.object(ofType: Preference.self, forPrimaryKey: "username")
                    username!.value = self.changeUsernameText
                }
            }
            
            self.isEditingName.toggle()
        }
        
        func resetTimer(realm: Realm, env: Env) {
            let timers = realm.objects(TimerTask.self)
            
            try? realm.write {
                for timer in timers {
                    realm.delete(timer)
                }
            }
        }
        
        func resetApp(realm: Realm, env: Env) -> Void {
            let timers = realm.objects(TimerTask.self)
            
            let username = realm.object(ofType: Preference.self, forPrimaryKey: "username")
            let onboarding = realm.object(ofType: Preference.self, forPrimaryKey: "hasFinishedOnboarding")
            
            try? realm.write {
                
                for timer in timers {
                    realm.delete(timer)
                }
                
                username!.value = ""
                onboarding!.value = "false"
            }
            
            env.username = ""
            env.onboarding = true
        }
    }
}
