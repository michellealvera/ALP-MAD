//
//  ContentView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedResults(
        Preference.self,
        where: { $0.key == "hasFinishedOnboarding" }
    ) var finishedOnboarding
    
    var body: some View {
        
        NavigationStack{
            VStack{
                MainView()
            }
        }
        
        .fullScreenCover(
            isPresented: Binding(get: { !(finishedOnboarding.first!.value == "true") }, set: {_ in }),
            content: {
                OnboardingView()
            }
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
   
    
    static var previews: some View {
        ContentView()
            .environment(\.realm, PreviewRealm.preview)
           
    }
}
