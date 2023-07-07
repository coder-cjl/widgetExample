//
//  LargeWidget.swift
//  LargeWidget
//
//  Created by 雷子 on 2023/7/6.
//

import WidgetKit
import SwiftUI
import Intents

struct LargeProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> LargeEntry {
        LargeEntry(date: Date(), configuration: LargeConfigurationIntent())
    }

    func getSnapshot(for configuration: LargeConfigurationIntent, in context: Context, completion: @escaping (LargeEntry) -> ()) {
        let entry = LargeEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: LargeConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [LargeEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = LargeEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct LargeEntry: TimelineEntry {
    let date: Date
    let configuration: LargeConfigurationIntent
}

struct LargeWidgetEntryView : View {
    var entry: LargeProvider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct LargeWidget: Widget {
    let kind: String = "LargeWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: LargeConfigurationIntent.self, provider: LargeProvider()) { entry in
            LargeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }
}

struct LargeWidget_Previews: PreviewProvider {
    static var previews: some View {
        LargeWidgetEntryView(entry: LargeEntry(date: Date(), configuration: LargeConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
