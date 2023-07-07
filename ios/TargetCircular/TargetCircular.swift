//
//  TargetCircular.swift
//  TargetCircular
//
//  Created by 雷子 on 2023/7/7.
//

import WidgetKit
import SwiftUI
import Intents

struct CircularProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> CircularEntry {
        CircularEntry(date: Date(), configuration: CircularConfigurationIntent())
    }

    func getSnapshot(for configuration: CircularConfigurationIntent, in context: Context, completion: @escaping (CircularEntry) -> ()) {
        let entry = CircularEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: CircularConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [CircularEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = CircularEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct CircularEntry: TimelineEntry {
    let date: Date
    let configuration: CircularConfigurationIntent
}

struct TargetCircularEntryView : View {
    var entry: CircularProvider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct TargetCircular: Widget {
    let kind: String = "TargetCircular"
    
    private var supportedFamilies: [WidgetFamily] {
        if #available(iOS 16.0, *) {
            return [.accessoryCircular]
        } else {
            return []
        }
    }
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: CircularConfigurationIntent.self, provider: CircularProvider()) { entry in
            TargetCircularEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies(supportedFamilies)
    }
}
