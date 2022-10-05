//
//  TestBar.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 12/5/21.
//

import SwiftUI

// A test version of a block for design/bug fixing purpouses.
struct TestBar: View {
    var rectLength : CGFloat = UIScreen.main.bounds.size.width - 40
    @State private var rectWidth = UIScreen.main.bounds.size.height/6
    @State private var barWidth = 40.0
    @State private var barPaddingTop = 10.0
    var fractionComplete = 0.05

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: rectLength - 50, height: barWidth)
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: rectLength - 50, height: barWidth)
                .foregroundColor(getColor(name: "B"))
                .opacity(0.3)
//            ZStack {
//                RoundedRectangle(cornerRadius: 20)
//                    .frame(width: (rectLength - 50) * fractionComplete, height: barWidth)
//                    .foregroundColor(.green)
//                RoundedRectangle(cornerRadius: 20)
//                    .frame(width: rectLength - 50, height: barWidth)
//                    .offset(x: (rectLength - 50)/2.0 - ((rectLength - 50) * fractionComplete)/2.0, y: 0)
//                    .opacity(0.3)
//            }
//            RoundedRectangle(cornerRadius: 20)
//                .frame(width: (rectLength - 50) * fractionComplete, height: barWidth)
//                .foregroundColor(.green)
//                .mask(
//                    RoundedRectangle(cornerRadius: 20)
//                        .frame(width: rectLength - 50, height: barWidth)
//                        .offset(x: rectLength - 50)/2.0 - ((rectLength - 50) * fractionComplete)/2.0, y: 0)
//                )
                //.clipShape(RoundedRectangle(cornerRadius: 20))
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder()
                .frame(width: rectLength - 50, height: barWidth)
                .foregroundColor(.black)
        }
        .padding(.top, barPaddingTop)
        
    }
}

struct TestBar_Previews: PreviewProvider {
    static var previews: some View {
        TestBar()
    }
}
