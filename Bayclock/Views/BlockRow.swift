//
//  BlockRow.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import SwiftUI

// View for an individual block
struct BlockRow: View {
    // This view needs a block passed into it
    var block: Block
    // You also need to pass in wether compressed mode is on
    var compressedIsOn: Bool
    // Sets the length + width of a block based on the size of the screen that is using the app
    @State private var rectLength = UIScreen.main.bounds.size.width - 40
    @State private var rectWidth = UIScreen.main.bounds.size.height/6
    @State private var barWidth = 40.0
    @State private var barPaddingTop = 10.0
    // This view needs a time passed in.
    var time: TimeStruct
    var body: some View {
        if (UserDefaults.standard.bool(forKey: "hideCompleted") == true && block.fractionComplete(time: time) == 1) {
            // If the user has chosen to hide blocks that are over for the day and the block is over, do not display anything
        }
        else {
            // Background rectangle that is set to the color of the block
            VStack {
                // Displays name of block + start and end times
                HStack() {
                    Text(getName(name: block.name))
                        .font(.headline)
                        .padding(.leading, (UIScreen.main.bounds.size.width - rectLength) / 2 + 25)
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(timeToString(hour: block.start.hour, minute: block.start.minute, second: 0 , hasSeconds: false)) - \(timeToString(hour: block.end.hour, minute: block.end.minute, second: 0 , hasSeconds: false))")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.trailing, (UIScreen.main.bounds.size.width - rectLength) / 2 + 25)

                }
                // Progress bar
                ZStack(alignment: .bottomLeading) {
                    // White background bar
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: rectLength - 50, height: barWidth)
                        .foregroundColor(.white)
                    // Mostly transparent bar that is the color of the block
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: rectLength - 50, height: barWidth)
                        .foregroundColor(getColor(name: block.name))
                        .opacity(0.3)
                    // Green progress bar
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: (rectLength - 50) * block.fractionComplete(time: time), height: barWidth)
                        .foregroundColor(.green)
                        .mask(
                            // Makes sure the progress bar fits witin the outline
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: rectLength - 50, height: barWidth)
                                    .offset(x: (rectLength - 50)/2 - ((rectLength - 50) * block.fractionComplete(time: time))/2 + 0.2, y: 0)
                            }
                        )
                    // If showPercentages is on and the block is more than 0% complete and less than 100% complete, display how complete the block is
                    if (block.fractionComplete(time: time) > 0 && block.fractionComplete(time: time) < 1 && UserDefaults.standard.bool(forKey: "showPercentages")) {
                        Text("\(String(format: "%.1f", block.fractionComplete(time: time) * 100))%")
                            .frame(width: rectLength - 50, height: barWidth)
                    }
                }
                // Adds spacing between the bar and the text.
                .padding(.top, barPaddingTop)
                
            }// End of entire block display
            .padding(.top, barWidth / 2)
            .padding(.bottom, barWidth / 2)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(getColor(name: block.name))
                    .saturation(1.2)
                    .padding(.leading, barWidth / 2)
                    .padding(.trailing, barWidth / 2)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
            )
            .onAppear {
                // Sets block sizes depending on wether compressed mode is on or not
                if (compressedIsOn == true) {
                    rectWidth = UIScreen.main.bounds.size.height/10
                    barWidth = 20.0
                    barPaddingTop = 0
                    rectLength = UIScreen.main.bounds.size.width - 5
                }
                else {
                    rectWidth = UIScreen.main.bounds.size.height/6
                    barWidth = 40.0
                    barPaddingTop = 10.0
                    rectLength = UIScreen.main.bounds.size.width - 40
                }
            } // End of onAppar
        } // End of "if hideCompleted = true {...} else {..}"
    }// End of body view
} // End of view

struct BlockRow_Previews: PreviewProvider {
    static var schedule = ModelData().schedule
    static var time = TimeStruct(year: 2021, month: 12, day: 5, weekday: 2, hour: 10, minute: 45, second: 7)
    static var previews: some View {
        BlockRow(block: schedule[0].blocks[0], compressedIsOn: true, time: time)
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            BlockRow(block: schedule[0].blocks[1], compressedIsOn: true, time: time)
                .previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
            BlockRow(block: schedule[0].blocks[2], compressedIsOn: false, time: time)
                .previewDevice(PreviewDevice(rawValue: "iPod touch (7th generation)"))
            
    
    }
}
