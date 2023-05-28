//
//  Timer.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation

// Study
// Time is stored in minutes

struct Timer: Identifiable, Hashable {
    
    var id: UUID
    var name: String
    var isActiveTimer: Bool
    var studyDuration: Int
    var studySessions: Int
    var shortBreakDuration: Int
    var longBreakDuration: Int
    
    init(
        id: UUID = UUID(),
        name: String,
        isActiveTimer: Bool,
        studyDuration: Int,
        studySessions: Int,
        shortBreakDuration: Int,
        longBreakDuration: Int
    ){
        self.id = id
        self.name = name
        self.isActiveTimer = isActiveTimer
        self.studyDuration = studyDuration
        self.studySessions = studySessions
        self.shortBreakDuration = shortBreakDuration
        self.longBreakDuration = longBreakDuration
    }
    
}

extension Timer {
    
    static let sampleTimer: Timer =
    Timer(
        name: "DefaultTimer",
        isActiveTimer: true,
        studyDuration: 25,
        studySessions: 2,
        shortBreakDuration: 5,
        longBreakDuration: 30
    )
    
    static let emptyTimer: Timer =
    Timer(
        name: "EmptyTimer",
        isActiveTimer: false,
        studyDuration: 0,
        studySessions: 0,
        shortBreakDuration: 0,
        longBreakDuration: 0
    )
    
}
