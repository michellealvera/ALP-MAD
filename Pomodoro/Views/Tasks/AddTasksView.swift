//
//  AddTimerView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 05/06/23.
//

import SwiftUI
import Combine

struct AddTasksView: View {
    
    // MARK: States
    
//    @State var quantity: Int = 10
    @State var timerName:String = ""
    
    let maxMinute = 59
    @State var minute: String = "1"
    @State var shortBreak: Int = 5
    @State var longBreak: Int = 10
    
    @State var enableLongBreak = false
    @State var enableAutomaticStop = false

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
                              .onReceive(Just(minute)) { _ in limitText(2) }
                         Rectangle()
                              .frame(height: 1)
                              .foregroundColor(.black)
                              .padding(.horizontal, 160)
                    }
                    
                }.frame(maxWidth: .infinity, alignment: .center)
                
                // Make this into a component
                // Pass in an individual State for each one
                
                // Short Break
                Text("Short Break")
                    .fontWeight(.bold)
                NumberPicker(quantity: shortBreak, maxQuantity: maxMinute)
                
                // Long Break
                HStack{
                    Toggle(isOn: $enableLongBreak){
                        Text("Long Break")
                            .fontWeight(.bold)
                    }
                    .tint(Color("Violet 500"))
                }
            
                NumberPicker(quantity: longBreak, maxQuantity: maxMinute)
                
    //            HStack{
    //                Toggle(isOn: $enableAutomaticStop) {
    //                    Text("Automatic Stop")
    //                        .fontWeight(.bold)
    //                }
    //                .tint(Color("Violet 500"))
    //            }
                
                VStack(alignment: .leading) {
                    Text("Long Break Starts After")
                        .fontWeight(.bold)
                        
                    
                    HStack(alignment: .center){
                        VStack {
                             TextField("", text: $minute)
                                  .padding(.horizontal, 16)
                                  .font(.headline)
                                  .keyboardType(.numberPad)
                                  .onReceive(Just(minute)) { _ in limitText(2) }
                             Rectangle()
                                  .frame(height: 1)
                                  .foregroundColor(.black)
                                  .padding(.horizontal, 160)
                        }
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
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
                
                
            }
//            .navigationTitle("Add Timer")
            .padding()
        }

//        .frame(maxHeight: .infinity, alignment: .top)
        
    }
    
    func limitText(_ upper: Int) {
        if minute.count > upper {
            minute = String(minute.prefix(upper))
        }
        
        let filtered = minute.filter { "0123456789".contains($0) }
        if filtered != minute {
            self.minute = filtered
        }
        
    }
    
    func saveNewTimer(){
        
        let theMinute = Int(minute)
        
    }
    
    
}

struct AddTimerView_Previews: PreviewProvider {
    static var previews: some View {
        AddTasksView()
    }
}
