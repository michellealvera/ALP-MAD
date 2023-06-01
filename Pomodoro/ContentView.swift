//
//  ContentView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let modelData = ModelData()
    
    static var previews: some View {
        ContentView()
            .environmentObject(modelData)
    }
}
