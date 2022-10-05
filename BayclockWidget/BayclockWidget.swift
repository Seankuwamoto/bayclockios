//
//  BayclockWidget.swift
//  BayclockWidget
//
//  Created by Sean Kuwamoto on 10/1/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}



struct BayclockWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Chemistry")
                .multilineTextAlignment(.leading)
                .font(.system(size: 18))
                .fontWeight(.semibold)
            HStack {
                VStack {
                    Text("10m left")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 13))
                    Text("B block")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 13))
                }
                
                Spacer()
                
            }
            Spacer()
            Text("Next")
                .multilineTextAlignment(.leading)
                .font(.system(size: 9))
                .foregroundColor(.secondary)
            Text("Spanish 3")
                .multilineTextAlignment(.leading)
                .font(.system(size: 13))
            Text("C block")
                .multilineTextAlignment(.leading)
                .font(.system(size: 13))
        }
        .padding(20)
        .frame(
              maxWidth: .infinity,
              maxHeight: .infinity,
              alignment: .topLeading
            )
        
    }
}

@main
struct BayclockWidget: Widget {
    let kind: String = "BayclockWidget"
        
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BayclockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct BayclockWidget_Previews: PreviewProvider {
    static var previews: some View {
        BayclockWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
