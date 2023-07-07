//
//  SmallWidget.swift
//  SmallWidget
//
//  Created by 雷子 on 2023/7/6.
//

import WidgetKit
import SwiftUI
import Intents

struct SmallProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> SmallEntry {
        SmallEntry(date: Date(), configuration: SmallConfigurationIntent())
    }

    func getSnapshot(for configuration: SmallConfigurationIntent, in context: Context, completion: @escaping (SmallEntry) -> ()) {
        let entry = SmallEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: SmallConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SmallEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SmallEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SmallEntry: TimelineEntry {
    let date: Date
    let configuration: SmallConfigurationIntent

    lazy var map: [String: Any]? = {
        let v = stringToMap(json: configuration.smallData?.json)
        return v
    }()
}

struct SmallWidgetEntryView : View {
    var entry: SmallProvider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct SmallWidget: Widget {
    let kind: String = "SmallWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SmallConfigurationIntent.self, provider: SmallProvider()) { entry in
            SmallWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetEntryView(entry: SmallEntry(date: Date(), configuration: SmallConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
