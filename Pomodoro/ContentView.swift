//
//  ContentView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @EnvironmentObject var env: Env
    
    var body: some View {
        
        NavigationStack{
            VStack{
                MainView()
            }
        }
        
        .fullScreenCover(
            isPresented:  $env.onboarding,
            content: {
                OnboardingView()
            }
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(Env())
            .environment(\.realm, PreviewRealm.preview)
        
    }
}
