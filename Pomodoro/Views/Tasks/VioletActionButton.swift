//
//  VioletActionButton.swift
//  Pomodoro
//
//  Created by MacBook Pro on 05/06/23.
//

import SwiftUI

struct VioletActionButton: View {
    var body: some View {
        Button(action: {
            //Place your action here
        }) {
            Image(systemName: "plus")
                .resizable()
                .scaledToFill()
                .frame(width: 28, height: 28)
                .padding(20)
        }
        .background(Color("Violet 500"))
        .foregroundColor (.white)
        .cornerRadius (.infinity)
        .padding()
    }
}

struct VioletActionButton_Previews: PreviewProvider {
    static var previews: some View {
        VioletActionButton()
    }
}
