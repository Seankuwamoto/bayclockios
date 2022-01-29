//
//  ModelData.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import Foundation
import Combine
import SwiftUI

final class ModelData: ObservableObject {
    // Loads the schedule from schedule.json
    @Published var schedule = scheduleToBetterSchedule(schedule: newLoad("schedule2.json")!, specialSchedule: newLoad("special_schedule.json")!)
}

func load<T: Decodable>(_ filename: String) -> T {
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
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func newLoad(_ filename: String) -> [String: Any]? {
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

// Converts Lucas' json schedule format into one more easily used by my program.
func scheduleToBetterSchedule(schedule: [String: Any], specialSchedule: [String: Any]) -> [Day] {
    var newSchedule: [Day] = []
    for day in ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"] {
        let blocks = schedule[day]
        var newBlocks: [Block] = []
        for (name, times) in blocks as! [String: [[Int]]] {
            newBlocks.append(Block(name: name, start: Block.Time(hour: times[0][0], minute: times[0][1]), end: Block.Time(hour: times[1][0], minute: times[1][1])))
        }
        newBlocks.sort {
            timeToSeconds(hour: $0.start.hour, minute: $0.start.minute, second: 0) < timeToSeconds(hour: $1.start.hour, minute: $1.start.minute, second: 0)
        }
        newSchedule.append(Day(day: day, blocks: newBlocks))
    }
    for (date, blocks) in specialSchedule {
        let currentDate = "\(getTime().year)/\(String(format: "%02d", getTime().month))/\(String(format: "%02d", getTime().day))"
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
    
    return newSchedule
}

