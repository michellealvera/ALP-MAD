//
//  NumberPicker.swift
//  Pomodoro
//
//  Created by MacBook Pro on 05/06/23.
//

import SwiftUI

struct NumberPicker: View {
    
    @State var quantity = 1
    
    var body: some View {
        HStack(spacing: 6) {
            HStack {
                Button(action: {
                    if quantity > 1 { quantity -= 1 }
                }) {
                    Text("-")
                        .font(.title)
                        .foregroundColor(Color("Grayscale Off-Black"))
                        .frame(width: 40, height: 40)
                        .padding(5)
                        .background(Color("Grayscale BG"))
                        .cornerRadius(.infinity)
                }
                
                Text("\(quantity)")
                    .font(.body)
                    .fontWeight(.medium)
                    .frame(minWidth: 60, minHeight: 40)
                
                Button(action: { quantity += 1 }) {
                    Text("+")
                        .font(.title)
                        .foregroundColor(Color("Grayscale Off-Black"))
                        .frame(width: 40, height: 40)
                        .padding(5)
                        .background(Color("Grayscale BG"))
                        .cornerRadius(.infinity)
                }
            }
            
        }.padding()
    }
}

struct NumberPicker_Previews: PreviewProvider {
    static var previews: some View {
        NumberPicker()
    }
}
