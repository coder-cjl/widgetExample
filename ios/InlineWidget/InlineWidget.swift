//
//  InlineWidget.swift
//  InlineWidget
//
//  Created by 雷子 on 2023/7/7.
//

import WidgetKit
import SwiftUI
import Intents

struct InlineProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> InlineEntry {
        InlineEntry(date: Date(), configuration: InlineConfigurationIntent())
    }

    func getSnapshot(for configuration: InlineConfigurationIntent, in context: Context, completion: @escaping (InlineEntry) -> ()) {
        let entry = InlineEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: InlineConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [InlineEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = InlineEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct InlineEntry: TimelineEntry {
    let date: Date
    let configuration: InlineConfigurationIntent
}

struct InlineWidgetEntryView : View {
    var entry: InlineProvider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct InlineWidget: Widget {
    let kind: String = "InlineWidget"
    
    private var supportedFamilies: [WidgetFamily] {
        if #available(iOS 16.0, *) {
            return [.accessoryCircular, .accessoryRectangular]
        } else {
            return []
        }
    }
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: InlineConfigurationIntent.self, provider: InlineProvider()) { entry in
            InlineWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies(supportedFamilies)
    }
}

