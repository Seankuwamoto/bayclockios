//
//  BlockRow.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import SwiftUI

struct BlockRow: View {
    var block: Block
    var compressedIsOn: Bool
    var rectLength = UIScreen.main.bounds.size.width - 40
    @State private var rectWidth = UIScreen.main.bounds.size.height/6
    @State private var barWidth = 40.0
    @State private var barPaddingTop = 10.0
    var time: TimeStruct
    var body: some View {
        if (UserDefaults.standard.bool(forKey: "hideCompleted") == true && block.fractionComplete(time: time) == 1) {
            
        }
        else {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(getColor(name: block.name))
                    .frame(width: rectLength, height: rectWidth)
                    .padding(.leading, 20)
                    .saturation(1.2)
                VStack {
                    HStack() {
                        Text(getName(name: block.name))
                            .font(.headline)
                            .padding(.leading, 50.0)
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(timeToString(hour: block.start.hour, minute: block.start.minute, second: 0 , hasSeconds: false)) - \(timeToString(hour: block.end.hour, minute: block.end.minute, second: 0 , hasSeconds: false))")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .padding(.trailing, 50)

                    }
                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: rectLength - 50, height: barWidth)
                            .foregroundColor(.white)
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: rectLength - 50, height: barWidth)
                            .foregroundColor(getColor(name: block.name))
                            .opacity(0.3)
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: (rectLength - 50) * block.fractionComplete(time: time), height: barWidth)
                            .foregroundColor(.green)
                            .mask(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: rectLength - 50, height: barWidth)
                                        .offset(x: (rectLength - 50)/2 - ((rectLength - 50) * block.fractionComplete(time: time))/2, y: 0)
                                }
                            )
                            //.clipShape(RoundedRectangle(cornerRadius: 20))
//                        RoundedRectangle(cornerRadius: 20)
//                            .strokeBorder()
//                            .frame(width: rectLength - 50, height: barWidth)
//                            .foregroundColor(.black)
                        if (block.fractionComplete(time: time) > 0 && block.fractionComplete(time: time) < 1) {
                            Text("\(String(format: "%.1f", block.fractionComplete(time: time) * 100))%")
                                .frame(width: rectLength - 50, height: barWidth)
                        }
                    }
                    .padding(.top, barPaddingTop)}
            }
            .onAppear {
                if (compressedIsOn == true) {
                    rectWidth = UIScreen.main.bounds.size.height/10
                    barWidth = 20.0
                    barPaddingTop = 3.0
                }
                else {
                    rectWidth = UIScreen.main.bounds.size.height/6
                    barWidth = 40.0
                    barPaddingTop = 10.0
                }
            }
        }
    }
}

struct BlockRow_Previews: PreviewProvider {
    static var schedule = ModelData().schedule
    static var time = TimeStruct(year: 2021, month: 12, day: 5, weekday: 2, hour: 10, minute: 45, second: 7)
    static var previews: some View {
        BlockRow(block: schedule[0].blocks[0], compressedIsOn: false, time: time)
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            BlockRow(block: schedule[0].blocks[1], compressedIsOn: false, time: time)
                .previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
            BlockRow(block: schedule[0].blocks[2], compressedIsOn: false, time: time)
                .previewDevice(PreviewDevice(rawValue: "iPod touch (7th generation)"))
            
    
    }
}
