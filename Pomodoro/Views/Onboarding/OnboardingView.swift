//
//  OnboardingView.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 03/06/23.
//

import SwiftUI
import RealmSwift

struct OnboardingView: View {
    @Environment(\.realm) var realm
    
   
    @StateObject var vm: ViewModel = ViewModel()
    
    var body: some View {
        TabView(selection: $vm.currentPage,
                content:  {
            
            ForEach(getPages()) { viewData in
                VStack {
                    Text(viewData.title)
                        .font(.largeTitle)
                    
                    Image(viewData.photo)
                    Spacer()
                    
                    viewData.bottom
                        .frame(width: 300)
                    Spacer()
                    
                }
            }
            
        })
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
    
    func getPages() -> [OnboardingPage] {
        return [
            OnboardingPage(id: 0, title: "Timer", photo: "onboarding-1") {
                AnyView(VStack(alignment: .leading, spacing: 5) {
                    Text("Organizing your life in a few minutes.")
                        .font(.system(size: 20, weight: .bold))
                    Text("Life in pomodoro sessions")
                        .font(.subheadline)
                }.frame(alignment: .leading))
            },
            
            OnboardingPage(id: 1, title: "Manage your time", photo: "onboarding-2") {
                
                AnyView(VStack(alignment: .leading, spacing: 20) {
                    ForEach([
                        "Set your own long and short break",
                        "Schedule your timer with automatic start and stop",
                        "Play some music while working"
                    ], id: \.self) { text in
                        HStack(spacing: 5) {
                            
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("Violet 500"))
                                .font(.system(size: 35))
                            
                            Text(text)
                                .foregroundColor(Color("Grayscale Body"))
                                .font(.subheadline)
                        }
                    }
                    
                })
            },
            
            OnboardingPage(id: 2, title: "", photo: "onboarding-3") {
                AnyView(VStack(spacing: 10) {
                    TextField("Your name", text: $vm.selectedUsername)
                        .padding()
                        .background(Color("Grayscale Input"))
                        .foregroundColor(Color("Grayscale Label"))
                        .cornerRadius(10)
                    
                    Button(action: {
                        vm.finishOnboarding(realm: realm)
                    }) {
                        HStack(alignment:.center, spacing: 10) {
                            Spacer()
                            
                            Text("Continue")
                                .foregroundColor(Color("Grayscale Off-White"))
                            
                            Image(systemName: SymbolHelper().arrowRight)
                                .foregroundColor(Color("Grayscale Off-White"))
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color("Violet 500"))
                    .cornerRadius(10)
                    
                }
                    .padding(.bottom, 50)
                    .frame(width: 300, alignment: .center))
            }
        ]
    }
    
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
