//
//  Timer.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation

// Study
// Time is stored in seconds

struct TimerTasks: Identifiable, Hashable, Codable {
    
    // Duration is the time
    // Session is the number of times the duration will happen
    
    var id: UUID
    var name: String
    var isActiveTimer: Bool
    
    var studyDuration: Int
    var studySessions: Int
    
    var shortBreakDuration: Int
    var shortBreakSessions: Int
    
    var isLongBreakEnabled: Bool
    var longBreakDuration: Int
    
    init(
        id: UUID = UUID(),
        name: String,
        isActiveTimer: Bool,
        studyDuration: Int,
        studySessions: Int,
        shortBreakDuration: Int,
        shortBreakSession: Int,
        longBreakEnabled: Bool,
        longBreakDuration: Int
    ){
        self.id = id
        self.name = name
        self.isActiveTimer = isActiveTimer
        
        self.studyDuration = studyDuration
        self.studySessions = studySessions
        
        self.shortBreakDuration = shortBreakDuration
        self.shortBreakSessions = shortBreakSession
        
        self.isLongBreakEnabled = longBreakEnabled
        self.longBreakDuration = longBreakDuration
    }
    
}

extension TimerTasks {
    
    static let sampleTimer: TimerTasks =
    TimerTasks(
        name: "DefaultTimer",
        isActiveTimer: true,
        studyDuration: 25,
        studySessions: 2,
        shortBreakDuration: 5,
        shortBreakSession: 2,
        longBreakEnabled: true,
        longBreakDuration: 30
    )
    
    static let emptyTimer: TimerTasks =
    TimerTasks(
        name: "EmptyTimer",
        isActiveTimer: false,
        studyDuration: 0,
        studySessions: 0,
        shortBreakDuration: 0,
        shortBreakSession: 0,
        longBreakEnabled: false,
        longBreakDuration: 0
    )
    
}
