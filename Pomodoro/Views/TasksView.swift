//
//  TasksView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import SwiftUI
import RealmSwift

struct TasksView: View {
    @Environment(\.realm) var realm
    @ObservedResults(
        TimerTask.self
    ) var allTimers
    
    var body: some View {
        NavigationStack {
            
            ZStack(alignment: .bottom) {
                
                if (!allTimers.isEmpty){
                    ScrollView(showsIndicators: false) {
                        
                        VStack{
                            
                            ForEach(allTimers){ timerTasks in
//                                Text(timerTasks.name)
                                
                                TasksItemView(
                                    theTimerTask: timerTasks
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
                    

                    NavigationLink(value: "AddTasksView") {
                        
                        VioletActionButton {
                            
                        }
                        
                    }
//                    .navigationDestination(for: String.self, destination: { view in
//                        if view == "AddTasksView" {
//                            AddTasksView()
//                        }
//                    })
                    
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
            .environment(\.realm, PreviewRealm.preview)
    }
}
