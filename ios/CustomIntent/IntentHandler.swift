//
//  IntentHandler.swift
//  CustomIntent
//
//  Created by 雷子 on 2023/7/6.
//

import Intents
import WidgetKit

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        return self
    }
}

extension IntentHandler: SmallConfigurationIntentHandling {

    func provideSmallDataOptionsCollection(for intent: SmallConfigurationIntent, with completion: @escaping (INObjectCollection<SmallData>?, Error?) -> Void) {
        var collection = [SmallData]()
        if let items = DataUtils.share.get(.systemSmall) {
            items.forEach({ json in
                if let map = stringToMap(json: json),
                   let key = map["type"] as? String {
                    let o = SmallData.init(identifier: key, display: key + " + small")
                    o.json = json
                    collection.append(o)
                }
            })
        }
        completion(INObjectCollection(items: collection), nil)
    }
}

extension IntentHandler: MediumConfigurationIntentHandling {
    
    func provideMediumDataOptionsCollection(for intent: MediumConfigurationIntent, with completion: @escaping (INObjectCollection<MediumData>?, Error?) -> Void) {
        var collection = [MediumData]()
        if let items = DataUtils.share.get(.systemMedium) {
            items.forEach { json in
                if let map = stringToMap(json: json),
                   let key = map["type"] as? String {
                    let o = MediumData.init(identifier: key, display: key + " + medium")
                    o.json = json
                    collection.append(o)
                }
            }
        }
        completion(INObjectCollection(items: collection), nil)
    }
}

extension IntentHandler: LargeConfigurationIntentHandling {
    
    func provideLargeDataOptionsCollection(for intent: LargeConfigurationIntent, with completion: @escaping (INObjectCollection<LargeData>?, Error?) -> Void) {
        var collection = [LargeData]()
        if let items = DataUtils.share.get(.systemLarge) {
            items.forEach { json in
                if let map = stringToMap(json: json),
                   let key = map["type"] as? String {
                    let o = LargeData.init(identifier: key, display: key + " + large")
                    o.json = json
                    collection.append(o)
                }
            }
        }
        completion(INObjectCollection(items: collection), nil)
    }
}

extension IntentHandler: InlineConfigurationIntentHandling {
    
    func provideInlineDataOptionsCollection(for intent: InlineConfigurationIntent, with completion: @escaping (INObjectCollection<InlineData>?, Error?) -> Void) {
        var collection = [InlineData]()
        if let items = DataUtils.share.get(.accessoryCircular) {
            items.forEach { json in
                if let map = stringToMap(json: json),
                   let key = map["type"] as? String {
                    let o = InlineData.init(identifier: key, display: key + " + circular")
                    o.json = json
                    collection.append(o)
                }
            }
        }
        completion(INObjectCollection(items: collection), nil)
    }
}
