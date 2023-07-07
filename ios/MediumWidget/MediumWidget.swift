//
//  MediumWidget.swift
//  MediumWidget
//
//  Created by 雷子 on 2023/7/6.
//

import WidgetKit
import SwiftUI
import Intents

struct MediumProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> MediumEntry {
        MediumEntry(date: Date(), configuration: MediumConfigurationIntent())
    }

    func getSnapshot(for configuration: MediumConfigurationIntent, in context: Context, completion: @escaping (MediumEntry) -> ()) {
        let entry = MediumEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: MediumConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MediumEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = MediumEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MediumEntry: TimelineEntry {
    let date: Date
    let configuration: MediumConfigurationIntent
}

struct MediumWidgetEntryView : View {
    var entry: MediumProvider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct MediumWidget: Widget {
    let kind: String = "MediumWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: MediumConfigurationIntent.self, provider: MediumProvider()) { entry in
            MediumWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidgetEntryView(entry: MediumEntry(date: Date(), configuration: MediumConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
