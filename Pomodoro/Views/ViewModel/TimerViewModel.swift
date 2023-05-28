//
//  TimerViewModel.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import Foundation

extension TimerView {
    final class ViewModal: ObservableObject {
        @Published var isActive = false
        @Published var showingAlert = false
        // Replace this with the users active timer duration
        @Published var time: String = "5:00"
        // Still need to create the logic for repeating the sessions and long breaks
        @Published var minutes: Float = 5.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
    }
    
    
}

