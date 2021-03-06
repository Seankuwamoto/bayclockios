//
//  Block.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import Foundation
import SwiftUI

// Adds an extention for the Double type that allows me to truncate it.
extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

// Defines a block struct that has a name, start time, and end time
struct Block: Hashable, Codable {
    var name: String
    var start: Time
    var end: Time
    
    struct Time: Hashable, Codable {
        var hour: Int
        var minute: Int
    }
    
    
    // Gets the current fraction that a block is completed. For example if a block started at 1:00 and ended at 2:00 and the current time was 1:50, the fraction complete would be 5/6
    func fractionComplete(time: TimeStruct) -> CGFloat {
        // Finds how long the block is
        let duration = timeToSeconds(hour: end.hour, minute: end.minute, second: 0) - timeToSeconds(hour: start.hour, minute: start.minute, second: 0)
        let returnValue = CGFloat(timeToSeconds(hour: time.hour, minute: time.minute, second: time.second) - timeToSeconds(hour: start.hour, minute: start.minute, second: 0))/CGFloat(duration)
        // Makes sure that the maximum % that a block can be is 1 and the minimum is 1
        if (returnValue > 1) {
            return 1.0
        }
        else if (returnValue < 0) {
            return 0
        }
        else {
            return returnValue
        }
    }
}

// Gets the user set name of a block from its original name.
func getName(name: String) -> String {
    // The default dictonrary of names before the user changes any of them.
    let blockNames: [String: String] = [
        "Morning Meeting": "Morning Meeting",
        "Group Advisory/1-on-1s": "Group Advisory/1-on-1s",
        "A": "A",
        "B": "B",
        "C": "C",
        "D": "D",
        "E": "E",
        "F": "F",
        "Lunch": "Lunch",
        "Tutorial": "Tutorial"
    ]
    
    // If the dictionary is not in user defaults, add it.
    if (UserDefaults.standard.dictionary(forKey: "blockNames") == nil) {
        UserDefaults.standard.set(blockNames, forKey: "blockNames")
    }
    
    // If this block is not in the dictionary, return the name (for example, this might be a special block)
    if (UserDefaults.standard.dictionary(forKey: "blockNames")![name] == nil) {
        return name
    }

    // If the name has been set to empty, return the original default.
    else if (UserDefaults.standard.dictionary(forKey: "blockNames")![name] as! String == "") {
        return blockNames[name]!
    }
    // Return the name they typed.
    else {
        return UserDefaults.standard.dictionary(forKey: "blockNames")![name] as! String
    }
    
}

// Turns a UIColor into data that is storable in UserDefaults.
func colorToData(_ c: UIColor) throws -> Data {
    do {
        let result = try NSKeyedArchiver.archivedData(withRootObject: c, requiringSecureCoding: false)
        return result
    } catch {
        print(error)
        throw error
    }
}

// Gets the color of a block based on its name.
func getColor(name: String) -> Color {
    

    
    //These are the old default colors. Still deciding on which ones to use.
//    let colorDict: [String: Data?] = [
//        "Morning Meeting":        try? colorToData(UIColor(Color(red: 131/255.0, green: 89/255.0, blue: 149/255.0))),
//        "Group Advisory/1-on-1s": try? colorToData(UIColor(Color(red: 131/255.0, green: 89/255.0, blue: 149/255.0))),
//        "A":                      try? colorToData(UIColor(Color(red: 190/255.0, green: 213/255.0, blue: 101/255.0))),
//        "B":                      try? colorToData(UIColor(Color(red: 0/255.0, green:144/255.0, blue: 166/255.0))),
//        "C":                      try? colorToData(UIColor(Color(red: 247/255.0, green: 183/255.0, blue: 78/255.0))),
//        "D":                      try? colorToData(UIColor(Color(red: 239/225.0, green: 145/255.0, blue: 62/255.0))),
//        "E":                      try? colorToData(UIColor(Color(red: 8/255.0, green: 158/255.0, blue: 180/255.0))),
//        "F":                      try? colorToData(UIColor(Color(red: 218/255.0, green: 82/255.0, blue: 101/255.0))),
//        "Lunch":                  try? colorToData(UIColor(Color(red: 82/255.0, green: 167/255.0, blue: 134/255.0))),
//        "Tutorial":               try? colorToData(UIColor(Color(red: 230/255.0, green: 217/255.0, blue: 67/255.0)))
//    ]
    // Set all default colors
    let colorDict: [String: Data?] = [
            "Morning Meeting":        try? colorToData(UIColor(Color(red: 90/255.0, green: 164/255.0, blue: 217/255.0))),
            "Group Advisory/1-on-1s": try? colorToData(UIColor(Color(red: 90/255.0, green: 164/255.0, blue: 217/255.0))),
            "A":                      try? colorToData(UIColor(Color(red: 90/255.0, green: 164/255.0, blue: 217/255.0))),
            "B":                      try? colorToData(UIColor(Color(red: 90/255.0, green: 164/255.0, blue: 217/255.0))),
            "C":                      try? colorToData(UIColor(Color(red: 90/255.0, green: 164/255.0, blue: 217/255.0))),
            "D":                      try? colorToData(UIColor(Color(red: 90/255.0, green: 164/255.0, blue: 217/255.0))),
            "E":                      try? colorToData(UIColor(Color(red: 90/255.0, green: 164/255.0, blue: 217/255.0))),
            "F":                      try? colorToData(UIColor(Color(red: 90/255.0, green: 164/255.0, blue: 217/255.0))),
            "Lunch":                  try? colorToData(UIColor(Color(red: 90/255.0, green: 164/255.0, blue: 217/255.0))),
            "Tutorial":               try? colorToData(UIColor(Color(red: 90/255.0, green: 164/255.0, blue: 217/255.0))),
            "Background":             try? colorToData(UIColor(Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0)))
        ]

    // Set colors to defaults if they do not exist
    if (UserDefaults.standard.dictionary(forKey: "colorDict") == nil) {
        UserDefaults.standard.set(colorDict, forKey: "colorDict")
    }
    
    
    // Get the color out of the dictionary, and return red if not found.
    if let colorData = UserDefaults.standard.dictionary(forKey: "colorDict")![name] as! Data? {
        do {
            if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
                return Color(color)
            }
        } catch {
            print("Couldn't understand what was stored in user defaults")
        }
    }

    // If all else fails, return blue color.
    return Color(red: 90/255.0, green: 164/255.0, blue: 217/255.0)
}

//Gets the name of the current class, or gets passing period + name of next class if they are inbetween classes
func getClass(schedule: [Day], time: TimeStruct) -> String {
    let currentSchedule = schedule[time.weekday - 2].blocks
    let numBlocks = currentSchedule.count
    let currentTime = timeToSeconds(hour: time.hour, minute: time.minute, second: time.second)
    var returnValue = ""
    // if the current time is before the start of the first block, school has not begun.
    if (timeToSeconds(hour: time.hour, minute: time.minute, second: time.second) < timeToSeconds(hour: currentSchedule[0].start.hour, minute: currentSchedule[0].start.minute, second: 0)) {
        returnValue =  "School has not begun"
    }
    // loops through all of the blocks in the array
    for index in 0...(numBlocks - 1) {
    
        // if the time is between the start and end of the current block, return the name of the block.
        if (currentTime > timeToSeconds(hour: currentSchedule[index].start.hour, minute: currentSchedule[index].start.minute, second: 0) && currentTime < timeToSeconds(hour: currentSchedule[index].end.hour, minute: currentSchedule[index].end.minute, second: 0)) {
            returnValue = "Current Block: \(getName(name: currentSchedule[index].name))"
        }
        
        if (currentTime > timeToSeconds(hour: currentSchedule[index].end.hour, minute: currentSchedule[index].end.minute, second: 0)) {
            // if the time is after the end of the current block, and the current block is the last block, return school is over.
            if (index + 1 == numBlocks) {
                returnValue = "School is over"
            }
            // if the time is after the end of the current block but before the start of the next, return passing period along with the name of the next block.
            else if (currentTime < timeToSeconds(hour: currentSchedule[index + 1].start.hour, minute: currentSchedule[index + 1].start.minute, second: 0)) {
                returnValue = "Passing period. Next Block: \(getName(name: currentSchedule[index + 1].name))"
            }
        }
    }
    return returnValue
}

// Returns the time left in the current block.
func timeLeft(schedule: [Day], time: TimeStruct) -> String {
    let currentSchedule = schedule[time.weekday - 2].blocks
    let numBlocks = currentSchedule.count
    let currentTime = timeToSeconds(hour: time.hour, minute: time.minute, second: time.second)
    var returnValue = ""

    // loops through all of the blocks in the array
    for index in 0...(numBlocks - 1) {
        if (currentTime > timeToSeconds(hour: currentSchedule[index].start.hour, minute: currentSchedule[index].start.minute, second: 0) && currentTime < timeToSeconds(hour: currentSchedule[index].end.hour, minute: currentSchedule[index].end.minute, second: 0)) {
            returnValue = "Time left: \((timeToSeconds(hour: currentSchedule[index].end.hour, minute: currentSchedule[index].end.minute, second: 0) - currentTime)/60 + 1) Minutes"
        }
    }
    return returnValue
}

