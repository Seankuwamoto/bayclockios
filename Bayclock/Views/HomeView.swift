//
//  HomeView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 1/27/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var modelData: ModelData
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var time = getTime()
    var body: some View {
        ZStack {
            getColor(name: "Background")
                .ignoresSafeArea()
            VStack() {
                if (whatBreakIsToday(breaks: modelData.breaks) != nil) {
                    Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                        .font(.largeTitle)
                        .padding(.top, UIScreen.main.bounds.size.height/2 - 80)
                    Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                    Text(whatBreakIsToday(breaks: modelData.breaks)!)
                }
                else if (time.weekday > 1 && time.weekday < 7){
                    Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                        .font(.title)
                        .padding(.top, 50.0)
                    Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                        .padding(.bottom, 50.0)
                    Text(getClass(schedule: modelData.schedule, time: time))
                    Text(timeLeft(schedule: modelData.schedule, time: time))
                }
                else {
                    Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                        .font(.largeTitle)
                        .padding(.top, UIScreen.main.bounds.size.height/2 - 80)
                    Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                    Text("Today is a weekend!")
                }
                if (time.weekday > 1 && time.weekday < 7 && whatBreakIsToday(breaks: modelData.breaks) == nil) {
                    ForEach(modelData.schedule[time.weekday - 2].blocks, id: \.self) { Block in
                        if (Block.fractionComplete(time: time) > 0.0 && Block.fractionComplete(time: time) < 1.0) {
                            BlockRow(block: Block, compressedIsOn: false, time: time)
                        }
                    }
                    Text("Today's lunch: " + "Placeholder")
                }
                
                Spacer()
            }
        }
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
