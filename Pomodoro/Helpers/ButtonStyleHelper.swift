//
//  ButtonStyleHelper.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import Foundation
import SwiftUI

// Pill Shape Filled - Violet 500
struct VioletFilledCapsuleButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor (.white)
                .padding(.vertical)
                .padding(.horizontal, 40)
                .background(Color("Violet 500"),in: Capsule())
    }
}

// Pill Shape Outline - Violet 500
struct VioletOutlinedCapsuleButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor(Color("Violet 500"))
                .padding(.vertical)
                .padding(.horizontal, 40)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(Color("Violet 500"), lineWidth: 2)
                )
    }
}

//struct EaseIn: ButtonStyle {
//
//    func makeBody(configuration: Configuration) -> some View {
//            configuration.label
//                .scaleEffect(configuration.isPressed ? 1.5 : 1)
//                .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
//    }
//}


