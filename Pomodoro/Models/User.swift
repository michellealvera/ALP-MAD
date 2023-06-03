//
//  User.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation

struct User: Codable {
    
    var name:String
    var timers:[TimerTasks]
    
    func getActiveTimer()->TimerTasks{
        
        if (timers.count == 1) {
            return timers[0]
        }
        
        return timers.first(where: { $0.isActiveTimer == true } ) ?? TimerTasks.emptyTimer
    }
    
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
        name: " ",
        timers: [TimerTasks.sampleTimer]
    )
    
}
