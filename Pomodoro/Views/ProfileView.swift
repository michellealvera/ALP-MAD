//
//  ProfileView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ProfileCardView(user: modelData.activeUser)
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static let modelData = ModelData()
    
    static var previews: some View {
        ProfileView()
            .environmentObject(modelData)
    }
}
