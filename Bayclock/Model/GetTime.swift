//
//  GetTime.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/26/21.
//

import Foundation
import Combine
import SwiftUI

// A structure for the time used throughout the program.
struct TimeStruct: Hashable, Codable {
    var year: Int
    var month: Int
    var day: Int
    var weekday: Int
    var hour: Int
    var minute: Int
    var second: Int
}

// Returns the current time in the TimeStruct format.
func getTime() -> TimeStruct {
    let date = Date()
    let calendar = Calendar.current
    
    let year = calendar.component(.year, from: date)
    let month = calendar.component(.month, from: date)
    let day = calendar.component(.day, from: date)
    let weekday = calendar.component(.weekday, from: date)
    let hour = calendar.component(.hour, from: date)
    let minute = calendar.component(.minute, from: date)
    let second = calendar.component(.second, from: date)
    
    return TimeStruct(year: year, month: month, day: day, weekday: weekday, hour: hour, minute: minute, second: second)
}

// Returns a date in the form of a string. Example: "Tuesday March 22nd"
func dateToString(weekday: Int, month: Int, day: Int) -> String {
    var weekdayString: String
    var monthString: String
    var dayString: String
    
    // Gets the weekday name
    if (weekday == 1) {
        weekdayString = "Sunday"
    }
    else if (weekday == 2) {
        weekdayString = "Monday"
    }
    else if (weekday == 3) {
        weekdayString = "Tuesday"
    }
    else if (weekday == 4) {
        weekdayString = "Wednesday"
    }
    else if (weekday == 5) {
        weekdayString = "Thursday"
    }
    else if (weekday == 6) {
        weekdayString = "Friday"
    }
    else {
        weekdayString = "Saturday"
    }
    
    // Gets the Month name
    if (month == 1) {
        monthString = "January"
    }
    else if (month == 2) {
        monthString = "February"
    }
    else if (month == 3) {
        monthString = "March"
    }
    else if (month == 4) {
        monthString = "April"
    }
    else if (month == 5) {
        monthString = "May"
    }
    else if (month == 6) {
        monthString = "June"
    }
    else if (month == 7) {
        monthString = "July"
    }
    else if (month == 8) {
        monthString = "August"
    }
    else if (month == 9) {
        monthString = "September"
    }
    else if (month == 10) {
        monthString = "October"
    }
    else if (month == 11) {
        monthString = "November"
    }
    else {
        monthString = "December"
    }
    
    // Gets the suffix for the current day of the month
    if (day == 1 || day == 21 || day == 31) {
        dayString = "\(day)st"
    }
    else if (day == 2 || day == 22) {
        dayString = "\(day)nd"
    }
    else if (day == 3 || day == 23) {
        dayString = "\(day)rd"
    }
    else {
        dayString = "\(day)th"
    }
    
    return "\(weekdayString) \(monthString) \(dayString)"
}

// Returns a time in the form of "HH:MM:SS" if hasSeconds is true and "HH:MM" if hasSeconds is false. Outputted time is not in military format (0:00 to 23:59), it is in the format of (12:00AM to 11:59PM). The input time is in military time.
func timeToString(hour: Int, minute: Int, second: Int, hasSeconds: Bool) -> String {
    var stringTime = ""
    if (hasSeconds) {
        if (hour < 12) {
            stringTime = "\(hour):\(String(format: "%02d", minute)):\(String(format: "%02d", second))AM"
        }
        else if (hour == 12) {
            stringTime = "\(hour):\(String(format: "%02d", minute)):\(String(format: "%02d", second))PM"
        }
        else
        {
            stringTime = "\(hour - 12):\(String(format: "%02d", minute)):\(String(format: "%02d", second))PM"
        }
    }
    else {
        if (hour < 12) {
            stringTime = "\(hour):\(String(format: "%02d", minute))AM"
        }
        else if (hour == 12) {
            stringTime = "\(hour):\(String(format: "%02d", minute))PM"
        }
        else
        {
            stringTime = "\(hour - 12):\(String(format: "%02d", minute))PM"
        }
    }
    
    return stringTime
}

// Turns a time of day into completely seconds. Useful for comparing times.
func timeToSeconds(hour: Int, minute: Int, second: Int) -> Int {
    return hour * 60 * 60 + minute * 60 + second
}

// Turns Lucas' inconsistant date format into a nomal one.
func normalizeDate(date: String) -> String {
    let year = date.split(separator: "/")[0]
    let month = String(format: "%02d", Int(date.split(separator: "/")[1]) ?? 0)
    let day = String(format: "%02d", Int(date.split(separator: "/")[2]) ?? 0)
    return "\(year)/\(month)/\(day)"

}

// takes in two dates as strings in the format of "YYYY/MM/DD".
func compareDates(date1: String, date2: String) -> Int {
    
    // breaks up the date strings and normalizes them.
    let split1 = date1.split(separator: "/")
    let year1 = Int(split1[0]) ?? 0
    let month1 = Int(split1[1]) ?? 0
    let day1 = Int(split1[2]) ?? 0

    let split2 = date2.split(separator: "/")
    let year2 = Int(split2[0]) ?? 0
    let month2 = Int(split2[1]) ?? 0
    let day2 = Int(split2[2]) ?? 0
   
    // returns 1 if the first date is greater, -1 if the second date is greater, and 0 if they are equal.
    if (year1 > year2) {
        return 1
    }
    else if (year1 < year2) {
        return -1
    }
    else {
        if (month1 > month2) {
            return 1
        }
        else if (month1 < month2) {
            return -1
        }
        else {
            if (day1 > day2) {
                return 1
            }
            else if (day1 < day2) {
                return -1
            }
            else {
                return 0
            }
        }
    }
    
}
