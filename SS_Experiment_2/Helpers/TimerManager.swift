//
//  TimerManager.swift
//  SS_Experiment_2
//
//  Created by Monty Boyer on 7/27/20.
//

import Foundation

// The timer has two states
enum TimerMode {
    case running
    case initial    // aka stopped
}

class TimerManager: ObservableObject {
   // Publish the state of the timer
   @Published var timerMode: TimerMode = .initial
   
   // Publish the expected arrival date time
   @Published var arrivalDateTime = Date()
  
   // Publish the remaining time, in minutes
   @Published var minutesRemaining: Int = 0
   
   
   // get a timer instance
   var timer = Timer()
   
   // TODO: the time interval should be sensitive to the method of travel
   var timeInterval = 60.0         // one minute
   
   func setArrivalDateTime(arrivalDate: Date)  {
      arrivalDateTime = arrivalDate
   }
   
   func setTimeRemaining(minutesRemaining: Int)  {
      self.minutesRemaining = minutesRemaining
   }
   
   func startTimer() {
      timerMode = .running
   }
    
    func stopTimer() {
       timerMode = .initial
    }
}
