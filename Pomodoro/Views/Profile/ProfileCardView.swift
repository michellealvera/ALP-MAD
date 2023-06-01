//
//  ProfileCardView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 01/06/23.
//

import SwiftUI

struct ProfileCardView: View {
    
    var user: User
    @State var confirmClearTimer: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6){
            Text("\(user.name)")
                .font(.title.bold())
                .multilineTextAlignment(.leading)
            
            
            Button {
                confirmClearTimer.toggle()
            } label: {
                
                HStack{
                    Image(systemName: SymbolHelper().delete)
                    
                    Text("Clear Timer")
                        .font(.callout)
                        .foregroundColor(Color("Grayscale Label"))
                }
                
            }
            
        }
//        .background(.thinMaterial).cornerRadius(20)
//        .overlay(
//            RoundedRectangle(cornerRadius: 20)
//                .background(Color("Grayscale BG")))
        .padding()
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity, alignment: .top)
        
    }
}

struct ProfileCardView_Previews: PreviewProvider {
    
    static let theUser = User.sampleUser
    
    static var previews: some View {
        ProfileCardView(user: theUser)
    }
}
