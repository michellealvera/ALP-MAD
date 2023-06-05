//
//  TasksView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import SwiftUI

struct TasksView: View {
    
    @Environment(\.realm) var realm
    
    @ObservedResults(
        Preference.self,
        where: { $0.key == "username" }
    ) var username
    
//    @State private var activeTimerUUID: UUID = UUID()
//    {
//        didSet {
//            if let activeTimer = modelData.activeUser.timers.first(where: { $0.isActiveTimer }) {
//                activeTimerUUID = activeTimer.id
//            } else {
//                // Set a default UUID value if no active timer is found
//                activeTimerUUID = UUID()
//            }
//        }
//    }
    
    var body: some View {
        NavigationStack {
            
            ZStack(alignment: .bottom) {
                
                if (!modelData.activeUser.timers.isEmpty){
                    ScrollView {
                        
                        VStack{
                            
                            ForEach(modelData.activeUser.timers){ timerTasks in
                                
                                TasksItemView(
                                    theTimerTask: timerTasks
                                    // activeTimerUUID: $activeTimerUUID
                                )
                            }
                        }
                        
                    }
                    .navigationTitle("Tasks")
                    .padding()
                    
                    
                } else {
                    
                    VStack{
                        Text("You have no tasks")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .navigationTitle("Tasks")
                    .padding()
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                }
                
                HStack{
                    
                    Spacer()
                    
                    VioletActionButton()
                    
                }.padding(.horizontal, 20)
                
            } //ZStack
            
        }
//        .onAppear{
//            self.activeTimerUUID = modelData.activeUser.getActiveTimer().id
//        }
        
    }
}

struct TasksView_Previews: PreviewProvider {
    
    static var previews: some View {
        TasksView()
            .environment(\.realm, Preference.previewRealm)
    }
}
