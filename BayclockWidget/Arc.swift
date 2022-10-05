//
//  Arc.swift
//  BayclockWidgetExtension
//
//  Created by Sean Kuwamoto on 10/1/22.
//

import Foundation
import SwiftUI

struct Arc : Shape {
    var radius: Float
    var thickness: Float
    var angle: Double
    
    func path(in rect: CGRect) -> Path {
        var p = Path()

        p.addArc(center: CGPoint(x: 10, y:10), radius: CGFloat(radius - thickness), startAngle: .degrees(270), endAngle: .degrees(angle + 270), clockwise: false)

        return p.strokedPath(.init(lineWidth: CGFloat(thickness), lineCap: .round))
    }
    
}
