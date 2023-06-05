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

    var body: some View {
        
        VStack{
            
            Text("Timer Name Goes Here")
            
            // Session Length - Hours, Minutes and Seconds
            Text("Session Length")
                .fontWeight(.bold)
            
            // Make this into a component
            // Pass in an individual State for each one
            
            // Short Break
            Text("Short Break")
            
            // Long Break
            Text("Long Break")
            
            
            Text("Automatic Stop")
                .fontWeight(.bold)
            Text("Stops After")
            
            
        }
        
    }
}

struct AddTimerView_Previews: PreviewProvider {
    static var previews: some View {
        AddTimerView()
    }
}
