//
//  MainView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import SwiftUI

// The Main View is responsible to hold the navigation tabs to all other views.
struct MainView: View {
    // State for holding the the users choise
    @State private var selection: Tab = .timer
    
    // For tagging the tabs
    enum Tab {
        case timer
        case tasks
        case profile
    }
    
    // Adding to Tabview and tagging them
    var body: some View {
        TabView(selection: $selection) {
            TimerView()
                .tabItem {
                    Label("Timer", systemImage: SymbolHelper().timer)
                }
                .tag(Tab.timer)

            TasksView()
                .tabItem{
                    Label("Tasks", systemImage:
                            SymbolHelper().tasks)
                }
                .tag(Tab.tasks)
            
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: SymbolHelper().profile)
                 }
                .tag(Tab.profile)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
