//
//  Timer.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation

// Study 

struct Timer {
    
    var name: String
    var isActiveTimer: Bool
    var studyDuration: Int
    var studySessions: Int
    var shortBreakDuration: Int
    var shortBreakSessions: Int
    var longBreakDuration: Int
    
    init(
        name: String,
        isActiveTimer: Bool,
        studyDuration: Int,
        studySessions: Int,
        shortBreakDuration: Int,
        shortBreakSessions: Int,
        longBreakDuration: Int
    ){
        self.name = name
        self.isActiveTimer = isActiveTimer
        self.studyDuration = studyDuration
        self.studySessions = studySessions
        self.shortBreakDuration = shortBreakDuration
        self.shortBreakSessions = shortBreakSessions
        self.longBreakDuration = longBreakDuration
        
    }
    
}
