//
//  OnboardingView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 01/06/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var showOnboardingPage: Bool
    
    var body: some View {
        TabView{
            
            OnboardingPagesView()
                .background(.blue)
            OnboardingPagesView()
                .background(.red)
            OnboardingPagesView()
                .background(.orange)
            
            // Part where we ask for their name
            // Pass the Binding to this specific view
            // Creates a different view
            
            
        }.tabViewStyle(PageTabViewStyle())
    }
}

//struct OnboardingView_Previews: PreviewProvider {
//
//    @State var showOnboardingPage: Bool = false
//
//    static var previews: some View {
//        OnboardingView(showOnboardingPage: $showOnboardingPage)
//    }
//}
