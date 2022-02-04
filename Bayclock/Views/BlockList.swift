//
//  BlockList.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import SwiftUI

struct BlockList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var barSpacing = 15.0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var time = getTime()
    
    var body: some View {
        ScrollView {
            VStack() {
                if (whatBreakIsToday(breaks: modelData.breaks) != nil){
                    Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                        .font(.largeTitle)
                        .padding(.top, UIScreen.main.bounds.size.height/2 - 80)
                    Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                    Text(whatBreakIsToday(breaks: modelData.breaks)!)
                }
                else if (time.weekday > 1 && time.weekday < 7) {
                    if (UserDefaults.standard.bool(forKey: "compressedMode") ==  true) {
                        
                        Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                            .font(.title)
                            .padding(.top, 10.0)
                        Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                            .padding(.bottom, 6.0)
                    }
                    else {
                        Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                            .font(.title)
                            .padding(.top, 50.0)
                        Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                            .padding(.bottom, 50.0)
                    }
                    Text(getClass(schedule: modelData.schedule, time: time))
                    Text(timeLeft(schedule: modelData.schedule, time: time))
                    if (UserDefaults.standard.bool(forKey: "compressedMode") ==  true) {
                        ForEach(modelData.schedule[time.weekday - 2].blocks, id: \.self) { Block in
                            BlockRow(block: Block, compressedIsOn: true, time: time)
                                .padding(.top, barSpacing)
                        }
                    }
                    else {
                        ForEach(modelData.schedule[time.weekday - 2].blocks, id: \.self) { Block in
                            BlockRow(block: Block, compressedIsOn: false, time: time)
                                .padding(.top, barSpacing)
                        }
                    }
                    
                }
                else {
                    Text("\(timeToString(hour: time.hour, minute: time.minute, second: time.second, hasSeconds: false))")
                        .font(.largeTitle)
                        .padding(.top, UIScreen.main.bounds.size.height/2 - 80)
                    Text(dateToString(weekday: time.weekday, month: time.month, day: time.day))
                    Text("Today is a weekend!")
                }
                Spacer()
            }
        }
        .onReceive(timer) { _ in
            time = getTime()
        }
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
