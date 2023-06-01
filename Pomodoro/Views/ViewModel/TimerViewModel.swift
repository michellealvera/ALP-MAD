//
//  TimerViewModel.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import Foundation

extension TimerView {
    final class ViewModal: ObservableObject {
        
//        var activeTimer: Timer
        
        // Help me think
        // CurrentSessionType uses Enum, Work / Short Break / Long Break
        // CurrentSessionCount comes from the timer information
        // CurrentSession takes according to SessionType
        
        enum sessionType {
            case Work
            case Short_Break
            case Long_Break
        }
        
        // What we need to display
        // The Literal Number on Screen
        // Translation to degrees in the view?
        
        let longBreakDuration = 180.0 // 3 Minutes
        var isLongBreakEnabled = false // get from User Timer
        
        @Published var isActive = false
        @Published var showingAlert = false
        // Replace this with the users active timer duration
        @Published var theTime: String = "1:25"
        @Published var sessionDuration: Float = 85.0 {
            didSet {
                self.theTime = convertToActualTime(timeInSeconds: sessionDuration)
            }
        }
        // Still need to create the logic for repeating the sessions and long breaks
        
        private var initialTime = 0
        private var endDate = Date()
        
        func start() {
            self.endDate = Date()
            self.isActive = true
            var theEndDate = Calendar.current.date(byAdding: .second, value: Int(sessionDuration), to: endDate)!
            self.endDate = theEndDate
        }

        func reset() {
            self.sessionDuration = Float(initialTime)
            self.isActive = false
            self.theTime = convertToActualTime(timeInSeconds: sessionDuration)
        }
        
        func convertToActualTime(timeInSeconds:Float)-> String{
            
            var theTimeInSeconds = timeInSeconds
            
            var hours = 0
            var minutes = 0
            var seconds = 0
            
            if(theTimeInSeconds > 3600){
                hours = Int(theTimeInSeconds / 3600)
                theTimeInSeconds = theTimeInSeconds - Float(hours)*3600
            }

            if(theTimeInSeconds > 60) {
                minutes = Int(theTimeInSeconds / 60)
                theTimeInSeconds = theTimeInSeconds - Float(minutes)*60
            }
            
            if(theTimeInSeconds > 1){
                seconds = Int(theTimeInSeconds)
            }
            
            
            if(hours != 0) {
                return "\(Int(hours)):\(Int(minutes)):\(Int(seconds))"
            }
            
            if(minutes != 0){
                return "\(Int(minutes)):\(Int(seconds))"
            }
            
            if(seconds != 0){
                return "\(Int(seconds))"
            }
            
            return "--:--:--"
        }
        
        func updateCountDown(){
            guard isActive else { return }
            
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0 {
                self.isActive = false
                self.theTime = "0:00"
                self.showingAlert = true
                return
            }

            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)

            self.sessionDuration = Float(minutes)
            self.theTime = String(format: "%d:%02d", minutes, seconds)
            
        }
        
        
    }
    
}

