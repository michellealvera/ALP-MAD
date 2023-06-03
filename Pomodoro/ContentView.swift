//
//  ContentView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("showOnboardingPages") var showOnboardingPage: Bool = false
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        NavigationStack{
            VStack{
                MainView()
            }
        }
        .fullScreenCover(
            isPresented: Binding(get: { !modelData.finishedOnboarding }, set: {_ in }),
            content: {
                OnboardingView()
            }
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let modelData = ModelData()
    
    static var previews: some View {
        ContentView()
            .environmentObject(modelData)
    }
}
