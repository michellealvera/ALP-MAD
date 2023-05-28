//
//  ModelData.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var activeUser: User = User.sampleUser
}
