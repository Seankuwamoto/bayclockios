//
//  DeveloperView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 12/5/21.
//

import SwiftUI

// Developer view that allows manually setting the time for bug fixing purposes. Currently disabled.
struct DeveloperView: View {
//    // toggle for "manual time" which means that time is set by the user instead of retrieved from the current date
//    @AppStorage("manualTime") var manualTime = false
//    var years = [2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020]
//    var months = [1,2,3,4,5,6,7,8,9,10]
//    var days = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
//    var weekdays = [1,2,3,4,5,6,7]
//    var hours = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
//    var minutes = [0,1,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60]
//    var seconds = [0,1,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60]
//    @State private var selectedYear = 2000
//    @State private var selectedMonth = 1
//    @State private var selectedDay = 1
//    @State private var selectedWeekday = 1
//    @State private var selectedHour = 12
//    @State private var selectedMinute = 34
//    @State private var selectedSecond = 56
    var body: some View {
        Text("Placeholder")
//        Toggle("Manual Time", isOn: $manualTime)
//        if (manualTime) {
//            VStack {
//                Picker("Choose a year", selection: $selectedYear) {
//                    ForEach(years, id: \.self) {
//                        Text($0)
//                    }
//                }
//                Picker("Choose a month", selection: $selectedMonth) {
//                    ForEach(months, id: \.self) {
//                        Text($0)
//                    }
//                }
//                Picker("Choose a day", selection: $selectedDay) {
//                    ForEach(days, id: \.self) {
//                        Text($0)
//                    }
//                }
//                Picker("Choose a weekday", selection: $selectedWeekday) {
//                    ForEach(weekdays, id: \.self) {
//                        Text($0)
//                    }
//                }
//                Picker("Choose a hour", selection: $selectedHour) {
//                    ForEach(hours, id: \.self) {
//                        Text($0)
//                    }
//                }
//                Picker("Choose a minute", selection: $selectedMinute) {
//                    ForEach(minutes, id: \.self) {
//                        Text($0)
//                    }
//                }
//                Picker("Choose a second", selection: $selectedSecond) {
//                    ForEach(seconds, id: \.self) {
//                        Text($0)
//                    }
//                }
//            }
//        }
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView()
    }
}
