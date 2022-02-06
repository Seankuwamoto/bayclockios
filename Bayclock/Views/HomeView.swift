//
//  HomeView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 1/27/22.
//

import SwiftUI

// Main homepage of the app.
struct HomeView: View {
    // Gets the schedule data.
    @EnvironmentObject var modelData: ModelData
    // Updates the view once every second
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    // Gets the current time.
    @State private var time = getTime()
    var body: some View {
        ZStack {
            // Sets the background color
            getColor(name: "Background")
                .ignoresSafeArea()
            VStack() {
                // If there is a currently ongoing break, print it
                if (whatBreakIsToday(breaks: modelData.breaks) != nil) {
                    Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                        .font(.largeTitle)
                        .padding(.top, UIScreen.main.bounds.size.height/2 - 80)
                    Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                    Text(whatBreakIsToday(breaks: modelData.breaks)!)
                }
                // If it is a weekday, print the schedule
                else if (time.weekday > 1 && time.weekday < 7){
                    Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                        .font(.title)
                        .padding(.top, 50.0)
                    Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                        .padding(.bottom, 50.0)
                    Text(getClass(schedule: modelData.schedule, time: time))
                    Text(timeLeft(schedule: modelData.schedule, time: time))
                }
                // if it's a weekend, print the weekened message.
                else {
                    Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                        .font(.largeTitle)
                        .padding(.top, UIScreen.main.bounds.size.height/2 - 80)
                    Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                    Text("Today is a weekend!")
                }
                // If there is no break today and it is a weekday, print the current block.
                if (time.weekday > 1 && time.weekday < 7 && whatBreakIsToday(breaks: modelData.breaks) == nil) {
                    // Goes through each block and sees if it is currently ongoing. If it is, display it.
                    ForEach(modelData.schedule[time.weekday - 2].blocks, id: \.self) { Block in
                        if (Block.fractionComplete(time: time) > 0.0 && Block.fractionComplete(time: time) < 1.0) {
                            BlockRow(block: Block, compressedIsOn: false, time: time)
                        }
                    }
                    // Prints today's lunch using Swift's Vision AI module to read the menu jpg. Currently is just a placeholder.
                    Text("Today's lunch: " + "Placeholder")
                }
                
                Spacer()
            } // End Vstack
        } // End ZStack
            // Sets the time to the current time once every second.
            .onReceive(timer) { _ in
                time = getTime()
            }
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ModelData())
    }
}
