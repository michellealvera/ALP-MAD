//
//  OnboardingViewModel.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 03/06/23.
//

import Foundation
import SwiftUI
import RealmSwift


extension OnboardingView {
    struct OnboardingPage: Identifiable {
        var id: Int
        var title: String
        var photo: String
        var bottom: AnyView
        
        init(id: Int, title: String, photo: String, @ViewBuilder bottom: @escaping () -> AnyView) {
            self.id = id
            self.title = title
            self.photo = photo
            self.bottom = bottom()
        }
    }
    
    class ViewModel: ObservableObject {
        
        
        @Published var currentPage = 0
        @Published var selectedUsername = ""
        
        
        func finishOnboarding(realm: Realm, env: Env) -> Void {
            if !selectedUsername.isEmpty {
                
                env.onboarding = false
                
                try? realm.write {
                    
                    let finishedOnboarding = realm.object(ofType: Preference.self, forPrimaryKey: "hasFinishedOnboarding")
                    let username = realm.object(ofType: Preference.self, forPrimaryKey: "username")
                    
                    finishedOnboarding!.value = "true"
                    username!.value = self.selectedUsername
                    
                }
            }
        }
    }
}
