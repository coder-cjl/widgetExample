//
//  DataUtils.swift
//  Runner
//
//  Created by 雷子 on 2023/7/6.
//

import Foundation

let widget_save_key = "widget_save_key"

class DataUtils {
    static let share = DataUtils()
    var widgetMap = [String: Any]()
    
    init() {
        if let value = DefaultUtils.share.getDictionary(forKey: widget_save_key) {
            widgetMap = value
        }
        print(widgetMap)
    }
    
    func add(json: String?) {
        guard let json = json,
              let map = stringToMap(json: json),
              let family = map["family"] as? String else  {
            return
        }
        
        if let type = WidgetFamilyEnum.init(rawValue: family) {
            add(type, json: json, map: map)
        }
    }
    
    func add(_ family: WidgetFamilyEnum, json: String, map: [String: Any]) {
        guard let type = map["type"] as? String else {
            return
        }
        
        let key = family.rawValue
        if var value = widgetMap[key] as? [String] {
            if !value.contains(where: {
                if let itemMap = stringToMap(json: $0),
                   let itemType = itemMap["type"] as? String {
                    return itemType == type
                } else {
                    return false
                }
            }) {
                value.append(json)
                widgetMap[key] = value
                refresh()
            }
        } else {
            var value = [String]()
            value.append(json)
            widgetMap[key] = value
            refresh()
        }
    }
    
    func remove(json: String?) {
        guard let json = json,
              let map = stringToMap(json: json),
              let family = map["family"] as? String else  {
            return
        }
        
        if let type = WidgetFamilyEnum.init(rawValue: family) {
            remove(type, json: json, map: map)
        }
    }
    
    
    func remove(_ family: WidgetFamilyEnum, json: String, map: [String: Any]) {
        guard let type = map["type"] as? String else {
            return
        }
        
        let key = family.rawValue
        guard var value = widgetMap[key] as? [String] else {
            return
        }
        
        value.removeAll { item in
            if let itemMap = stringToMap(json: item),
               let itemType = itemMap["type"] as? String {
                return itemType == type
            } else {
                return false
            }
        }
        
        widgetMap[key] = value
        refresh()
    }
    
    func refresh() {
        DefaultUtils.share.set(value: widgetMap, forKey: widget_save_key)
        print(widgetMap)
    }
    
    func get(_ family: WidgetFamilyEnum) -> [String]? {
        print(widgetMap)
        let key = family.rawValue
        if let value = widgetMap[key] as? [String] {
            return value
        } else {
            return nil
        }
    }
}
