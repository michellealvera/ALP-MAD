//
//  TimerViewModel.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import Foundation
import Combine
import RealmSwift

enum sessionType {
    case Work
    case Short_Break
    case Long_Break
}

extension TimerView {
    final class ViewModel: ObservableObject {
        
        var activeTimer: TimerTask = TimerTask(
            name: "DefaultTimer",
            isActiveTimer: true,
            studyDuration: 25,
            studySessions: 4,
            shortBreakDuration: 1,
            longBreakEnabled: false,
            longBreakDuration: 0
        )
        
        // MARK: Timer Operations
        @Published var isActive = false
        @Published var isPause = false
        @Published var showingAlert = false
        var currentSession = sessionType.Short_Break
        var lapsedSession = 0
        
        // MARK: Hour:Minute:Second Text
        // Replace this with the users active timer duration
        var originalTime: String = "3:00"
        @Published var theTime: String = "3:00"
        var originalDuration: Double = 3.0
        @Published var sessionDuration: Double = 3.0 {
            didSet {
                self.theTime = convertToActualTime(timeInSeconds: sessionDuration*60)
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
        
        private var cancellables = Set<AnyCancellable>()
        
//        init() {
//            $sessionDuration
//                    .sink { value in
//                        // Handle the updated value of number
////                        print("Number updated: \(value)")
//                        // You can perform additional operations here
//
//                        self.theTime = self.convertToActualTime(timeInSeconds:value)
//
//                    }
//                    .store(in: &cancellables)
//            }
            
//        deinit {
//            cancellables.forEach { $0.cancel() }
//        }
        
        
        // FIXME: Timer Problem
        func setup(realm: Realm){
            
            // Define the predicate to filter for isActiveTimer = true
            let predicate = NSPredicate(format: "isActiveTimer == true")

            // Retrieve all objects of the Timer model class that match the predicate
            if let retrievedTimer = realm.objects(TimerTask.self).filter(predicate).first {
                self.activeTimer = TimerTask(
                    name: "DefaultTimer",
                    isActiveTimer: true,
                    studyDuration: 2,
                    studySessions: 2,
                    shortBreakDuration: 1,
                    longBreakEnabled: true,
                    longBreakDuration: 3
                )
                
            } else {
                self.activeTimer = TimerTask(
                    name: "DefaultTimer",
                    isActiveTimer: true,
                    studyDuration: 1,
                    studySessions: 4,
                    shortBreakDuration: 1,
                    longBreakEnabled: false,
                    longBreakDuration: 0
                )
            }
            
            determineNextAction()
        }
        
        func start() {
            self.endDate = Date()
            self.isActive = true
            let theEndDate = Calendar.current.date(byAdding: .second, value: Int(sessionDuration), to: endDate)!
            self.endDate = theEndDate
        }
        
        func resume(){
            self.isActive = true
            self.isPause = false
        }
        
        func pause(){
            self.isActive = false
            self.isPause = true
        }

        func reset() {
            self.isActive = false
            self.isPause = false
            
            self.theTime = originalTime
            self.sessionDuration = originalDuration
            
            self.toProgress = originalProgress
            self.toAngle = originalAngle
        }
        
        func determineNextAction(){
            
            if (currentSession == sessionType.Work){
                
                // Execute Break Session
                batchSetTime(theMinutes: Double(activeTimer.shortBreakDuration))
                currentSession = sessionType.Short_Break
                self.start()
                
            } else if (currentSession == sessionType.Short_Break) {
                
                // Check to do work again
                if (activeTimer.studySessions != lapsedSession) {
                    
                    lapsedSession += 1
                    batchSetTime(theMinutes: Double(activeTimer.studyDuration))
                    currentSession = sessionType.Work
                    self.start()
                
                // Check long break enabled
                } else if (activeTimer.isLongBreakEnabled) {
                    
                    batchSetTime(theMinutes: Double(activeTimer.longBreakDuration))
                    currentSession = sessionType.Long_Break
                    self.start()
                }
                
            } else if (currentSession == sessionType.Long_Break) {
                
                batchSetTime(theMinutes: Double(activeTimer.studyDuration))
                self.reset()
                currentSession = sessionType.Work
            }
            
        }
        
        func batchSetTime(theMinutes:Double){
            
            originalTime = convertToActualTime(timeInSeconds: theMinutes*60)
            theTime = convertToActualTime(timeInSeconds: theMinutes*60)
            originalDuration = theMinutes*60
            sessionDuration = theMinutes*60
            
        }
        
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
            
            var minutes = 0.0
            var seconds = 0.0
            
            if(theTimeInSeconds > 60) {
                minutes = (theTimeInSeconds / 60).rounded()
                theTimeInSeconds -= minutes*60
            }
            
            if(theTimeInSeconds > 1){
                seconds = theTimeInSeconds
            }
            
            
            if(minutes != 0){
                return String(format: "%d:%02d", minutes, seconds)
            }
            
            if(seconds != 0){
                return String(format: "00:%02d", seconds)
            }
            
            return "--:--:--"
        }
        
        func updateCountDown(){
            guard isActive else { return }
            
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0 {
                self.isActive = false
                self.theTime = "00:00"
//                self.showingAlert = true
                
//                self.reset()
                determineNextAction()
                
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

