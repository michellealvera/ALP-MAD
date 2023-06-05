//
//  TimerViewModel.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import Foundation
import Combine

enum sessionType {
    case Work
    case Short_Break
    case Long_Break
}

extension TimerView {
    final class ViewModel: ObservableObject {
        
        var activeTimer: TimerTasks = TimerTasks.sampleTimer
        
        // MARK: Timer Operations
        @Published var isActive = false
        @Published var showingAlert = false
        var currentSession = sessionType.Work
        
        // MARK: Hour:Minute:Second Text
        // Replace this with the users active timer duration
        var originalTime: String = "3:00"
        @Published var theTime: String = "3:00"
//        {
//            convertToActualTime(timeInSeconds:originalDuration)
//        }
        let originalDuration: Double = 180.0
        @Published var sessionDuration: Double = 181.0 {
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
        
        private var cancellables = Set<AnyCancellable>()
        
        init() {
            $sessionDuration
                    .sink { value in
                        // Handle the updated value of number
//                        print("Number updated: \(value)")
                        // You can perform additional operations here
                        
                        self.theTime = self.convertToActualTime(timeInSeconds:value)
                                                
                    }
                    .store(in: &cancellables)
            }
            
        deinit {
            cancellables.forEach { $0.cancel() }
        }
        
        
        func setup(activeTimer: TimerTasks){
            self.activeTimer = activeTimer
        }
        
        func start() {
            self.endDate = Date()
            self.isActive = true
            let theEndDate = Calendar.current.date(byAdding: .second, value: Int(sessionDuration), to: endDate)!
            self.endDate = theEndDate
        }
        
        func resume(){
            self.isActive = true
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
                self.theTime = "00:00"
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

