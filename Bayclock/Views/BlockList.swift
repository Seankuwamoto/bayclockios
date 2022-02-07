//
//  BlockList.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import SwiftUI

struct BlockList: View {
    // Imports the schedule from modelData.swift
    @EnvironmentObject var modelData: ModelData
    // Variable for bar spacing. Changes when compressedMode = true
    @State private var barSpacing = 15.0
    // Updates page once every second
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    // Recieves the time from the getTime function in GetTime.swift
    @State private var time = getTime()
    
    var body: some View {
        ZStack {
            // Sets the background color
            getColor(name: "Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack() {
                    // If there is a break today, replace normal schedule with break message.
                    if (whatBreakIsToday(breaks: modelData.breaks) != nil){
                        // Displays the time
                        Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                            .font(.largeTitle)
                            .padding(.top, UIScreen.main.bounds.size.height/2 - 80)
                        // Displays the date
                        Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                        // Displays the break
                        Text(whatBreakIsToday(breaks: modelData.breaks)!)
                    }
                    // If it is a school day, proceed.
                    else if (time.weekday > 1 && time.weekday < 7) {
                        // If compressed mode is on, display the compressed versions of time and date
                        if (UserDefaults.standard.bool(forKey: "compressedMode") ==  true) {
                            // Displays the time
                            Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                                .font(.title)
                                .padding(.top, 10.0)
                            // Displays the date
                            Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                                .padding(.bottom, 6.0)
                        }
                        // If compressed mode is off, display the normal versions of time and date
                        else {
                            // Displays the time
                            Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                                .font(.title)
                                .padding(.top, 50.0)
                            // Displays the date
                            Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                                .padding(.bottom, 50.0)
                        }
                        // Displays the current class. Displays Passing + next class if it is passing period
                        Text(getClass(schedule: modelData.schedule, time: time))
                        // Displays the time left in the current class.
                        Text(timeLeft(schedule: modelData.schedule, time: time))
                        if (UserDefaults.standard.bool(forKey: "compressedMode") ==  true) {
                            ForEach(modelData.schedule[time.weekday - 2].blocks, id: \.self) { Block in
                                // Displays each block in today's schedule (compressed)
                                BlockRow(block: Block, compressedIsOn: true, time: time)
                                    .padding(.top, barSpacing)
                            }
                        }
                        else {
                            // Displays each block in today's schedule (non-compressed)
                            ForEach(modelData.schedule[time.weekday - 2].blocks, id: \.self) { Block in
                                BlockRow(block: Block, compressedIsOn: false, time: time)
                                    .padding(.top, barSpacing)
                            }
                        }
                        
                    }
                    // If it is not a weekday or a break, proceed.
                    else {
                        // Displays date, time, and weekend message.
                        Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                            .font(.largeTitle)
                            .padding(.top, UIScreen.main.bounds.size.height/2 - 80)
                        Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                        Text("Today is a weekend!")
                    }
                    Spacer()
                } // End VStack (vertical stack of stuff)
            } // End ScrollView (Scrollable area)
        } // End ZStack
        // Updates the time every second
        .onReceive(timer) { _ in
            time = getTime()
        }
        // Sets bar spacing to match compressed mode when this view appears
        .onAppear {
            if (UserDefaults.standard.bool(forKey: "compressedMode") ==  true) {
                barSpacing = 2.0
            }
            else {
                barSpacing = 10.0
            }
        }
    }
}

struct BlockList_Previews: PreviewProvider {
    static var previews: some View {
        BlockList()
            .environmentObject(ModelData())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
        BlockList()
            .environmentObject(ModelData())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        BlockList()
            .environmentObject(ModelData())
            .previewDevice(PreviewDevice(rawValue: "iPod touch (7th generation)"))
    }
}
