//
//  ProfileCardView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 01/06/23.
//

import SwiftUI

struct ProfileCardView: View {
    
    var user: User
    
    var body: some View {
        
        VStack(spacing: 6){
            Text("\(user.name)")
        }
        .frame(maxHeight: .infinity, alignment: .top)
        
        
    }
}

struct ProfileCardView_Previews: PreviewProvider {
    
    static let theUser = User.sampleUser
    
    static var previews: some View {
        ProfileCardView(user: theUser)
    }
}
