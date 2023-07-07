//
//  TimeWidget.swift
//  Runner
//
//  Created by 雷子 on 2023/7/5.
//

import SwiftUI
import WidgetKit


struct TimeWidget: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var widgetData: FlutterTimeWidgetData
    
    var body: some View {
        ZStack {
            switch family {
            case .systemSmall:
                TimeSmallWidget(widgetData: widgetData)
            case .systemMedium:
                TimeMediumWidget(widgetData: widgetData)
            case .systemLarge:
                TimeLargeWidget(widgetData: widgetData)
            case .systemExtraLarge:
                TimeLargeWidget(widgetData: widgetData)
            case .accessoryCorner:
                TimeSmallWidget(widgetData: widgetData)
            case .accessoryCircular:
                TimeSmallWidget(widgetData: widgetData)
            case .accessoryRectangular:
                TimeSmallWidget(widgetData: widgetData)
            case .accessoryInline:
                TimeSmallWidget(widgetData: widgetData)
            default:
                TimeSmallWidget(widgetData: widgetData)
            }
        }
    }
}

struct TimeWidget_Previews: PreviewProvider {
    static var previews: some View {
        TimeWidget(widgetData: FlutterTimeWidgetData())
    }
}


struct TimeSmallWidget: View {
    
    var widgetData: FlutterTimeWidgetData
    
    var body: some View {
        Text("Time samll")
    }
}


struct TimeMediumWidget: View {
    
    var widgetData: FlutterTimeWidgetData
    
    var body: some View {
        Text("Time medium")
    }
}

struct TimeLargeWidget: View {
    
    var widgetData: FlutterTimeWidgetData
    
    var body: some View {
        Text(widgetData.family == .systemLarge ? widgetData.time ?? "" : "Time large")
    }
}
