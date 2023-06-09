//
//  AddTimerView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 05/06/23.
//

import SwiftUI
import Combine
import RealmSwift

struct AddTasksView: View {
    
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    
    // MARK: States
    
//    @State var quantity: Int = 10
    @State var timerName:String = ""
    
    let maxMinute = 59
    @State var minute: String = "1"
    
    @State var shortBreak: Int = 2
    @State var studySession: String = "1"
    
    @State var longBreak: Int = 5
    @State var enableLongBreak = false

    var body: some View {
        
        NavigationStack{
            
            Text("Add Timer")
                .navigationBarTitleDisplayMode(.inline)
                .font(.headline)
                .fontWeight(.heavy)
//                .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(alignment: .leading, spacing: 6){
                
                Text("Timer Name")
                    .fontWeight(.bold)
                TextField("Input Timer Name", text: $timerName)
                    .padding()
                    .background(Color("Grayscale BG"))
                    .cornerRadius(16)
                    .padding(.bottom, 20)
                
                // Session Length - Hours, Minutes and Seconds
                Text("Session Length")
                    .fontWeight(.bold)
                
                HStack(alignment: .center){
                    VStack {
                         TextField("", text: $minute)
                              .padding(.horizontal, 16)
                              .multilineTextAlignment(.center)
                              .font(.title)
                              .keyboardType(.numberPad)
                              .onReceive(Just(minute)) { _ in limitTextMinute(2) }
                         Rectangle()
                              .frame(height: 1)
                              .foregroundColor(Color("Grayscale Label"))
                              .padding(.horizontal, 160)
                    }
                    
                }.frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 20)
                
                // Make this into a component
                // Pass in an individual State for each one
                
                // Short Break
                Text("Short Break Duration")
                    .fontWeight(.bold)
                NumberPicker(quantity: shortBreak, maxQuantity: maxMinute)
                    .padding(.bottom, 20)
                
                // Long Break
                HStack{
                    Toggle(isOn: $enableLongBreak){
                        Text("Long Break Duration")
                            .fontWeight(.bold)
                    }
                    .tint(Color("Violet 500"))
                }
            
                NumberPicker(quantity: longBreak, maxQuantity: maxMinute)
                    .padding(.bottom, 20)
                
    //            HStack{
    //                Toggle(isOn: $enableAutomaticStop) {
    //                    Text("Automatic Stop")
    //                        .fontWeight(.bold)
    //                }
    //                .tint(Color("Violet 500"))
    //            }
                
                HStack(alignment: .center, spacing: 8) {
                    
                    Text("Long Break Starts After")
                        .fontWeight(.medium)
//                        .padding(.trailing, 10)
                    
                    
                    VStack(alignment: .center) {
                        
                        TextField("", text: $studySession)
//                            .frame(width: 120)
                            .padding(.leading, 16)
                            .multilineTextAlignment(.trailing)
                            .font(.headline)
                            .keyboardType(.numberPad)
                            .onReceive(Just($studySession)) { _ in limitTextMinute(2) }
                             
//                             .frame(height: 1)
//                             .foregroundColor(.black)
                        
//                        Rectangle()
//                            .frame(height: 1)
//                            .foregroundColor(.black)
                    }
                    
                    Text("Session")
                        .font(.headline)
                    
//                    HStack(alignment: .center){
//                        VStack {
//                             TextField("", text: $minute)
//                                  .padding(.horizontal, 16)
//                                  .font(.headline)
//                                  .keyboardType(.numberPad)
//                                  .onReceive(Just(minute)) { _ in limitText(2) }
//                             Rectangle()
//                                  .frame(height: 1)
//                                  .foregroundColor(.black)
//                                  .padding(.horizontal, 160)
//                        }
                        
//                    }.frame(maxWidth: .infinity, alignment: .leading)
                }

                
                
                Button {
                    saveNewTimer()
                } label: {
                    Text("Add Timer")
                        .fontWeight(.medium)
                        .foregroundColor(Color("Grayscale Off-White"))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("Violet 500"))
                .cornerRadius(8)
                .padding(.vertical, 40)
                
                
            }
//            .navigationTitle("Add Timer")
            .padding()
        }

//        .frame(maxHeight: .infinity, alignment: .top)
        
    }
    
    func limitTextMinute(_ upper: Int) {
        if minute.count > upper {
            minute = String(minute.prefix(upper))
        }
        
        let filtered = minute.filter { "0123456789".contains($0) }
        if filtered != minute {
            self.minute = filtered
        }
        
    }
    
    func limitTextSession(_ upper: Int) {
        if studySession.count > upper {
            studySession = String(studySession.prefix(upper))
        }
        
        let filtered = studySession.filter { "0123456789".contains($0) }
        if filtered != studySession {
            self.studySession = filtered
        }
        
    }
    
    func saveNewTimer(){
        
        if let safeMinute = Int(minute) {
            
            if let safeStudy = Int(studySession) {
                
                
                let newTimer = TimerTask(
                    name: timerName,
                    isActiveTimer: false,
                    studyDuration: safeMinute,
                    studySessions: safeStudy,
                    shortBreakDuration: shortBreak,
                    longBreakEnabled: enableLongBreak,
                    longBreakDuration: longBreak
                )
                
                try? realm.write {
                  realm.add(newTimer)
                }
                dismiss()
                
            }

        }
    }
    
    
}

struct AddTimerView_Previews: PreviewProvider {
    static var previews: some View {
        AddTasksView()
    }
}
