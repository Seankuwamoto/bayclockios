//
//  ModelData.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import Foundation
import Combine
import SwiftUI

// Makes the modelData available to all views.
final class ModelData: ObservableObject {
    // Loads the schedule from schedule.json
    @Published var schedule = scheduleToBetterSchedule(schedule: load("schedule.json")!, specialSchedule: load("special_schedule.json")!, immersives: load("immersives.json")!)
    @Published var breaks = load("breaks.json")
}

// Loads a file into memory from a file name or URL.
func load(_ filename: String) -> [String: Any]? {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        return json
    } catch {
        fatalError("Couldn't parse \(filename) :\n\(error)")
    }
}

// Converts Lucas' json schedule format into one more easily used by my program. Lucas, if you are reading this WRITE YOUR JSONS BETTER. PLEASE. I had to add a lot of extra lines just do deal with your unusable json style. There are even some cases where your files have a date formatted as YYYY/MM/DD and then later on in the file there is a date formatted as YYYY/M/D. WTF Lucas!
func scheduleToBetterSchedule(schedule: [String: Any], specialSchedule: [String: Any], immersives: [String: Any]) -> [Day] {
    var newSchedule: [Day] = []
    // Loops through each day and sets it to the normal schedule for that day. Fixes the json format so that there are no keys with arbitrary names.
    for day in ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"] {
        let blocks = schedule[day]
        var newBlocks: [Block] = []
        for (name, times) in blocks as! [String: [[Int]]] {
            newBlocks.append(Block(name: name, start: Block.Time(hour: times[0][0], minute: times[0][1]), end: Block.Time(hour: times[1][0], minute: times[1][1])))
        }
        // Sorts the blocks by start time.
        newBlocks.sort {
            timeToSeconds(hour: $0.start.hour, minute: $0.start.minute, second: 0) < timeToSeconds(hour: $1.start.hour, minute: $1.start.minute, second: 0)
        }
        newSchedule.append(Day(day: day, blocks: newBlocks))
    }
    
    // If one of the dates marked in special_schedule.json is today, replace the normal day schedule with the special one.
    let currentDate = "\(getTime().year)/\(String(format: "%02d", getTime().month))/\(String(format: "%02d", getTime().day))"
    for (date, blocks) in specialSchedule {
        if  currentDate == normalizeDate(date: date) {
            var newBlocks: [Block] = []
            for (name, times) in blocks as! [String: [[Int]]] {
                newBlocks.append(Block(name: name, start: Block.Time(hour: times[0][0], minute: times[0][1]), end: Block.Time(hour: times[1][0], minute: times[1][1])))
            }
            newBlocks.sort {
                timeToSeconds(hour: $0.start.hour, minute: $0.start.minute, second: 0) < timeToSeconds(hour: $1.start.hour, minute: $1.start.minute, second: 0)
            }
            newSchedule[getTime().weekday - 2].blocks = newBlocks
        }
    }
    // Because of Lucas' bad json format, I have to manually write these two pieces of code for immersive 1 and 2.
    if let immersive1 = immersives["Immersive1"] as! [String]? {
        if (compareDates(date1: currentDate, date2: immersive1[0]) > 0 && compareDates(date1: currentDate, date2: immersive1[1]) < 0) {
            if let immersive1Schedule = immersives["Immersive1 Schedule"] as! [String: [[Int]]]? {
                var newBlocks: [Block] = []
                for (name, times) in immersive1Schedule {
                    newBlocks.append(Block(name: name, start: Block.Time(hour: times[0][0], minute: times[0][1]), end: Block.Time(hour: times[1][0], minute: times[1][1])))
                }
                newBlocks.sort {
                    timeToSeconds(hour: $0.start.hour, minute: $0.start.minute, second: 0) < timeToSeconds(hour: $1.start.hour, minute: $1.start.minute, second: 0)
                }
                newSchedule[getTime().weekday - 2].blocks = newBlocks
            }
        }
    }
    
    if let immersive2 = immersives["Immersive2"] as! [String]? {
        if (compareDates(date1: currentDate, date2: immersive2[0]) > 0 && compareDates(date1: currentDate, date2: immersive2[1]) < 0) {
            if let immersive2Schedule = immersives["Immersive2 Schedule"] as! [String: [[Int]]]? {
                var newBlocks: [Block] = []
                for (name, times) in immersive2Schedule {
                    newBlocks.append(Block(name: name, start: Block.Time(hour: times[0][0], minute: times[0][1]), end: Block.Time(hour: times[1][0], minute: times[1][1])))
                }
                newBlocks.sort {
                    timeToSeconds(hour: $0.start.hour, minute: $0.start.minute, second: 0) < timeToSeconds(hour: $1.start.hour, minute: $1.start.minute, second: 0)
                }
                newSchedule[getTime().weekday - 2].blocks = newBlocks
            }
        }
    }
    // returns the schedule.
    return newSchedule
}

// If there is a break during the current day, output the name of the break.
func whatBreakIsToday(breaks: [String: Any]?) -> String? {
    var returnValue: String? = nil
    if let unwrappedBreaks = breaks as! [String: [String]]? {
        let currentDate = "\(getTime().year)/\(String(format: "%02d", getTime().month))/\(String(format: "%02d", getTime().day))"
        for (name, dates) in unwrappedBreaks {
            if (compareDates(date1: currentDate, date2: dates[0]) > 0 && compareDates(date1: currentDate, date2: dates[1]) < 0) {
                returnValue = name
            }
        }
    }
    
    return returnValue
}
