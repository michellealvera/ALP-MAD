//
//  User.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation

struct User {
    
    var name:String
    var timers:[TimerTasks]
    
    mutating func clearAllTimer(){
        
        if(timers.isEmpty) { return }
        self.timers.removeAll()
    }
    
    init(name username:String, timers: [TimerTasks]){
        self.name = username
        self.timers = timers
    }
    
}


extension User {

    static let sampleUser: User =
    User(
        name: "DefaultName",
        timers: [TimerTasks.sampleTimer]
    )
    
}
