//
//  ContentView.swift
//  SS_Experiment_2
//
//  Created by Monty Boyer on 7/27/20.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var timeInPicker = Date()
    @State private var destinationString = ""
    @State private var mapCoordinate =
        // Set initial location in Honolulu
        MKCoordinateRegion(center: CLLocationCoordinate2D(
                                        latitude: 21.282778,
                                        longitude: -157.829444),
                           span: MKCoordinateSpan(
                                        latitudeDelta: 0.1,
                                        longitudeDelta: 0.1))
    

    // track the timer manager
    @ObservedObject var timerManager = TimerManager()

    // create a date range for the next 24 hours
    var within24Hours: ClosedRange<Date> {
        let now = Calendar.current.date(byAdding: .minute, value: +1, to: Date())!
        let tomorrow = Calendar.current.date(byAdding: .day, value: +1, to: Date())!
        return now...tomorrow
    }
    
    var body: some View {
        VStack {
            if #available(iOS 14.0, *) {
                Map(coordinateRegion: $mapCoordinate)
                    .edgesIgnoringSafeArea(.bottom)
                    .padding(.top, -20)
            } else {
                Text("Need iOS 14 to see the map.")
            }
            
            VStack(spacing: 10) {
                Form {
                    Section(header: Text("Journey info")
                        .font(.headline)
                        //.padding()
                    )
                    {
                        DatePicker("Arrival time",
                                   selection: $timeInPicker,
                                   in: within24Hours,
                                   displayedComponents: .hourAndMinute)
                        //Spacer()
                        
                        TextField("Destination address, e.g. '465 Oak St, Akron, OH'", text: $destinationString)
                            .font(.subheadline)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        }
                    }
                }
                .frame(height: 130)
            
                /*
                Button(action: {} ) {
                    Text("Go")
                        .padding(8)
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(12)
                */
                    
                // image for the play or pause buttons depending on the timer state
                Image(systemName: timerManager.timerMode == .running ? "stop.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .foregroundColor(.green)
                    
                    .onTapGesture {
                        // if initial state get the picker selection and set, save it
                        if self.timerManager.timerMode == .initial {
                            // get & validate the arrival time
                            
                            // set the time remaining
                            self.timerManager.setTimeRemaining(minutesRemaining: 30)
                            
                            // transition to tracking / progress view
                        }
                        
                        // a tap toggles the running and initial states
                        self.timerManager.timerMode == .running ?
                            self.timerManager.stopTimer() :
                            self.timerManager.startTimer()
                    }
            
            }

    }   // body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
