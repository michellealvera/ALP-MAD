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
    @State private var selection: Tab? = .timer
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    // For tagging the tabs
    enum Tab: CaseIterable, Identifiable {
        var id : String { UUID().uuidString }
        case timer
        case tasks
        case profile
        
        var title: String {
            switch self {
            case .timer:
                return "Timer"
            case .profile:
                return "Profile"
            case .tasks:
                return "Tasks"
            default:
                return "Test"
            }
        }
        
        var icon: String {
            switch self {
            case .timer:
                return SymbolHelper().timer
            case .profile:
                return SymbolHelper().profile
            case .tasks:
                return SymbolHelper().tasks
            }
        }
        
    }
    
    // Adding to Tabview and tagging them
    var body: some View {
        
        
        // MARK: - iOS iPhone View
        if idiom == .phone {
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
        
        // MARK: - iOS iPad Views
        if idiom == .pad {
            NavigationSplitView {
                List(Tab.allCases, selection: $selection) { item in
                    
                    HStack(spacing: 10) {
                        Image(systemName: item.icon)
                            .foregroundColor(Color("Violet 500"))
                        Text(item.title)
                    }.onTapGesture {
                        selection = item
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Clockly")
                
                
            } detail: {
                if let page = selection {
                    switch page {
                    case .profile:
                        ProfileView()
                        
                    case .tasks:
                        TasksView()
                    case .timer:
                        TimerView()
                        
                    }
                }
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.realm, PreviewRealm.preview)
        
    }
}
