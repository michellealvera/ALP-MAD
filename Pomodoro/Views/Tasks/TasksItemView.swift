//
//  TasksItemView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 05/06/23.
//

import SwiftUI

struct TasksItemView: View {
        
    var theTimerTask: TimerTasks
    @State var shownSheet: Bool = false
    
    var body: some View {
        
        VStack(){
            
            HStack(spacing: 6){
                Text("\(theTimerTask.name)")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    
                Spacer()
                
                Button{
                    
                    if(theTimerTask.isActiveTimer){
//                        toggleToNonActive(timerTask: theTimerTask)
//                        theTimerTask.isActiveTimer = false
                    } else {
//                        toggleToActive(timerTask: theTimerTask)
                    }
//                    shownSheet.toggle()
                    
                } label: {
                    
                    if theTimerTask.isActiveTimer {
                        Text("Active")
                            .fontWeight(.medium)
                    } else {
                        Text("Non-Active")
                            .font(.callout)
                            .foregroundColor(Color("Grayscale Label"))
                    }

                }.sheet(isPresented: $shownSheet){
                    TasksDialogSheet(shownSheet: $shownSheet, theUUID: theTimerTask.id)
                        .presentationDetents([.fraction(0.20)])
                        .presentationDragIndicator(.visible)
                }
                
                
//                .alert("Timer Set to Active", isPresented: $shownAsActive) {
//                    Button("OK", role: .cancel) { }
//                }
                
                
            }
            .padding(.top, 24)
            .padding(.horizontal)
            
            
            HStack(){
                
                Image(systemName: SymbolHelper().timer)
                    .foregroundColor(Color("Grayscale Label"))
                Text("\(theTimerTask.studyDuration):00")
                    .foregroundColor(Color("Grayscale Label"))
                
                Spacer()
                
                Image(systemName: SymbolHelper().hotDrink)
                    .foregroundColor(Color("Grayscale Label"))
                Text("\(theTimerTask.shortBreakDuration):00")
                    .foregroundColor(Color("Grayscale Label"))
                
                Spacer()
                
                Image(systemName: SymbolHelper().bed)
                    .foregroundColor(Color("Grayscale Label"))
                Text("\(theTimerTask.longBreakDuration):00")
                    .foregroundColor(Color("Grayscale Label"))
                
            }
            .padding()
            .padding(.bottom, 18)
            .frame(maxWidth: .infinity)
            
            
        }
        .padding(.horizontal, 12)
        .background(Color("Grayscale BG"))
            .clipShape( RoundedRectangle( cornerRadius: 16 ) )
        .onTapGesture {
            
            if !theTimerTask.isActiveTimer {
                shownSheet.toggle()
            }
        }
        
    }
    
    func toggleToNonActive(timerTask: inout TimerTasks) {
        timerTask.isActiveTimer = false
    }
    
    func toggleToActive(timerTask: inout TimerTasks) {
        timerTask.isActiveTimer = true
    }
    
    
}

struct TasksItemView_Previews: PreviewProvider {
    
    static var sampleTimer = TimerTasks.sampleTimer
    static var emptyTimer = TimerTasks.emptyTimer
//    @State static var activeTimerUUID = TimerTasks.sampleTimer.id
    
    static var previews: some View {
        VStack(){
            
            TasksItemView(
                theTimerTask: sampleTimer)
            
            TasksItemView(
                theTimerTask: emptyTimer)
            
        }

    }
}
