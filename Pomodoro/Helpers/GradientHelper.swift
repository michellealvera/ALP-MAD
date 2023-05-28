//
//  GradientHelper.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import Foundation
import SwiftUI

struct GradientHelper {
    
    static let violetFuschiaGradient = AngularGradient(
        gradient: Gradient(colors: [Color("Fuschia 500"), Color("Violet 500")]),
        center: .center,
        startAngle: .degrees(342),
        endAngle: .degrees(0)
    )
    
    static let fuschiaVioletGradient = AngularGradient(
        gradient: Gradient(colors: [Color("Violet 500"), Color("Fuschia 500")]),
        center: .center,
        startAngle: .degrees(342),
        endAngle: .degrees(0)
    )
    
}
