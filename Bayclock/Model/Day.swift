//
//  Day.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import Foundation
import SwiftUI

// Defines a struct for a day which contains the name of the day and an array of all the blocks in it
struct Day: Hashable, Codable {
    var day: String
    var blocks: [Block]
}
