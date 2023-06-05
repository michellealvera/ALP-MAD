//
//  TasksDialogSheet.swift
//  Pomodoro
//
//  Created by MacBook Pro on 05/06/23.
//

import SwiftUI

struct TasksDialogSheet: View {
    
    @EnvironmentObject var modelData:ModelData
    
    @Binding var shownSheet: Bool
    var theUUID: UUID
    
    var body: some View {
        
        VStack {
            
            Text("Would you like to make \n this Timer Task Active?")
                .font(.headline)
                .padding(.vertical)
            
            HStack(spacing: 50) {
                
                Button {
                    
                    shownSheet.toggle()
                    
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color("Violet 500"))
                        .padding(.vertical)
                        .padding(.horizontal, 28)
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(Color("Violet 500"), lineWidth: 2)
                        )
                }
                
                
                Button {
                    
                    shownSheet.toggle()
                    modelData.activeUser.setTimerAsActive(theID: theUUID)
                    
                } label: {
                    Text("Set Active")
                        .foregroundColor (.white)
                        .padding(.vertical)
                        .padding(.horizontal, 20)
                        .background(Color("Violet 500"),in: Capsule())
                        
                }
                
                
            }.padding(.horizontal, 25)
            
            
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
}

struct TasksDialogSheet_Previews: PreviewProvider {
    
    @State static var shownSheet: Bool = true
    @State static var activeTimerUUID = TimerTasks.sampleTimer.id
    
    static var previews: some View {
        TasksDialogSheet(
            shownSheet: $shownSheet,
            theUUID: activeTimerUUID
        )
    }
}
