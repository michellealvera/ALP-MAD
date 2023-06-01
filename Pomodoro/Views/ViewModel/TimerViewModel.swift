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
        // Current Session Type uses Enum, Work / Short Break / Long Break
        // Current Session Count comes from the timer information
        
        @Published var isActive = false
        @Published var showingAlert = false
        // Replace this with the users active timer duration
        @Published var time: String = "25:00"
        // Still need to create the logic for repeating the sessions and long breaks
        @Published var minutes: Float = 25.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        
        private var initialTime = 0
        private var endDate = Date()
        
        func start() {
            self.endDate = Date()
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
        }

        func reset() {
            self.minutes = Float(initialTime)
            self.isActive = false
            self.time = "\(Int(minutes)) :00"
        }
        
        func updateCountDown(){
            guard isActive else { return }
            
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0 {
                self.isActive = false
                self.time = "0:00"
                self.showingAlert = true
                return
            }

            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)

            self.minutes = Float(minutes)
            self.time = String(format: "%d:%02d", minutes, seconds)
            
        }
        
        
    }
    
}

