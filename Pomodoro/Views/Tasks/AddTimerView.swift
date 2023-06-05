//
//  AddTimerView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 05/06/23.
//

import SwiftUI

struct AddTimerView: View {
    
    // MARK: States
    @State var quantity: Int = 10
    @State var timerName:String = ""

    var body: some View {
        
        VStack(alignment: .leading, spacing: 6){
            
            Text("Timer Name")
            TextField("Input Timer Name", text: $timerName)
                .padding()
                .background(Color("Grayscale BG"))
                .cornerRadius(16)
            
            // Session Length - Hours, Minutes and Seconds
            Text("Session Length")
                .fontWeight(.bold)
            
            HStack{
                // Three TextFields
            }
            
            // Make this into a component
            // Pass in an individual State for each one
            
            // Short Break
            Text("Short Break")
            NumberPicker(quantity: 5)
            
            // Long Break
            Text("Long Break")
            NumberPicker(quantity: 25)
            
            Text("Automatic Stop")
                .fontWeight(.bold)
            Text("Stops After")
            
            
//            Button {
//
//            } label: {
//                Text("Add Timer")
//                    .fontWeight(.medium)
//                    .foregroundColor(Color("Grayscale Off-White"))
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color("Violet 500"))
//            .cornerRadius(8)
            
            
        }
        .padding()
        
    }
}

struct AddTimerView_Previews: PreviewProvider {
    static var previews: some View {
        AddTimerView()
    }
}
