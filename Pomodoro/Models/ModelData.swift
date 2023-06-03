//
//  ModelData.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import Foundation
import SwiftUI


final class ModelData: ObservableObject {
    
    @AppStorage("hasFinishedOnboarding") var finishedOnboarding = false
    @JsonAppStorage("user", defaultValue: User.sampleUser) var activeUser: User
    
}
