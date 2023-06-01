//
//  TimerViewModel.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import Foundation

extension TimerView {
    final class ViewModel: ObservableObject {
        
        var activeTimer: TimerTasks = TimerTasks.sampleTimer

//        init(theActiveTimer: TimerTasks = TimerTasks.sampleTimer){
//            self.activeTimer = theActiveTimer
//        }
        // On hold because we can't get the activeTimer from the View
        
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
        
        // MARK: Timer Operations
        @Published var isActive = false
        @Published var showingAlert = false
        
        // MARK: Hour:Minute:Second Text
        // Replace this with the users active timer duration
        let originalTime = "1:25"
        @Published var theTime: String = "1:25"
        let originalDuration: Double = 85.0
        @Published var sessionDuration: Double = 85.0 {
            didSet {
                self.theTime = convertToActualTime(timeInSeconds: sessionDuration)
            }
        }
        
        // MARK: Circular Slidar Properties
        let originalAngle: Double = 342.0
        @Published var toAngle: Double = 342.0
        let originalProgress = 0.95
        @Published var toProgress: CGFloat = 0.95
        
        // Still need to create the logic for repeating the sessions and long breaks
        
        private var initialTime = 0
        private var endDate = Date()
        
        func setup(activeTimer: TimerTasks){
            self.activeTimer = activeTimer
        }
        
        func start() {
            self.endDate = Date()
            self.isActive = true
            let theEndDate = Calendar.current.date(byAdding: .second, value: Int(sessionDuration), to: endDate)!
            self.endDate = theEndDate
        }
        
        func pause(){
            self.isActive = false
        }

        func reset() {
            self.isActive = false
            
            self.theTime = originalTime
            self.sessionDuration = originalDuration
            
            self.toProgress = originalProgress
            self.toAngle = originalAngle
        }
        
        //
        func calculateAngle(recentTime: Double){
            
            // 5.96 is full
            // 0.0 is dead center
            
            let radians = (recentTime / originalDuration) * 5.96
            // Converting into Angle
            var angle = radians * 180 / .pi
            if angle < 0{angle = 360 + angle}
            // Progress
            let progress = angle / 360
            
            // Update To Values
            self.toAngle = angle
            self.toProgress = progress
            
        }
        
        func convertToActualTime(timeInSeconds:Double)-> String{
            
            var theTimeInSeconds = timeInSeconds
            
            var hours = 0.0
            var minutes = 0.0
            var seconds = 0.0
            
//            calculateAngle(recentTime: theTimeInSeconds)
            
            if(theTimeInSeconds > 3600){
                hours = (theTimeInSeconds / 3600).rounded()
                theTimeInSeconds -= hours*3600
            }

            if(theTimeInSeconds > 60) {
                minutes = (theTimeInSeconds / 60).rounded()
                theTimeInSeconds -= minutes*60
            }
            
            if(theTimeInSeconds > 1){
                seconds = theTimeInSeconds
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
                
                self.reset()
                
                return
            }
            
            calculateAngle(recentTime: sessionDuration)

            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
//            let hours = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)

//            self.sessionDuration = Double(hours)*3600 + Double(minutes)*60 + seconds
            self.sessionDuration = Double(minutes)*60 + Double(seconds)
            self.theTime = String(format: "%d:%02d", minutes, seconds)
            
        }
        
        
    }
    
}

