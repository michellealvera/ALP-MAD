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
    
    func setTimerAsActive(theID: UUID) {
        
        // Find the previous active timer and then make it false
        
        if var oldActiveTimer = self.timers.first(where: {$0.isActiveTimer}) {
            oldActiveTimer.isActiveTimer = false
        }
        
//        self.timers.filter{ $0.isActiveTimer }.forEach{
//            $0.isActiveTimer = false
//        }
        
        // Get the tTimer according to the UUID and make it true
        
        if var newActiveTimer = self.timers.first(where: {$0.id == theID}) {
            newActiveTimer.isActiveTimer = true
        } else {
            return
        }
        
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
        timers: [
            TimerTasks.sampleTimer,
            TimerTasks.emptyTimer
        ]
    )
    
}
