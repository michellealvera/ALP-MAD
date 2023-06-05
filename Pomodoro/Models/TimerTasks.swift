//
//  Timer.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation
import RealmSwift

class TimerTask: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var isActiveTimer: Bool = false
    @Persisted var studyDuration: Int = 0
    @Persisted var shortBreakDuration: Int = 0
    @Persisted var studySessions: Int = 0
    @Persisted var isLongBreakEnabled: Bool = false
    @Persisted var longBreakDuration: Int = 0
    
    convenience init(
        name: String,
        isActiveTimer: Bool,
        studyDuration: Int,
        studySessions: Int,
        shortBreakDuration: Int,
        longBreakEnabled: Bool,
        longBreakDuration: Int
    ){
        self.init()
        self.name = name
        self.isActiveTimer = isActiveTimer
        
        self.studyDuration = studyDuration
        self.studySessions = studySessions
        
        self.shortBreakDuration = shortBreakDuration
        
        self.isLongBreakEnabled = longBreakEnabled
        self.longBreakDuration = longBreakDuration
    }
    
}
