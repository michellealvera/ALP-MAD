//
//  OnboardingViewModel.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 03/06/23.
//

import Foundation
import SwiftUI


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
        
        func finishOnboarding(env: ModelData) -> Void {
            if !selectedUsername.isEmpty {
                
                let newUser = User(
                    name: selectedUsername,
                    timers: []
                )
                
                withAnimation {
                    env.finishedOnboarding = true
                    env.activeUser = newUser
                }
            }
        }
    }
}
