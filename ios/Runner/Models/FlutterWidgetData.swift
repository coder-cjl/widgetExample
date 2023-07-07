//
//  FlutterWidgetData.swift
//  Runner
//
//  Created by 雷子 on 2023/7/5.
//

import Foundation
import HandyJSON

enum WidgetEnum: String, HandyJSONEnum {
    case time = "time"
    case photo = "photo"
    case weather = "weather"
}

func filterType(type: String) -> HandyJSON.Type? {
    let filters = [
        "time": FlutterTimeWidgetData.self,
        "photo": FlutterPhotoWidgetData.self,
    ] as [String : HandyJSON.Type]
    return filters[type]
}



protocol FlutterBaseWidgetData {
    var type: WidgetEnum? { get }
}

struct FlutterTimeWidgetData: HandyJSON, FlutterBaseWidgetData {
    var type: WidgetEnum? = .time
    var family: WidgetFamilyEnum?
    var kind: String?
    var displayName: String?
    var description: String?
    var time: String?
}

struct FlutterPhotoWidgetData: HandyJSON, FlutterBaseWidgetData {
    var type: WidgetEnum? = .photo
    var family: WidgetFamilyEnum?
    var kind: String?
    var displayName: String?
    var description: String?
    var photo: String?
}
