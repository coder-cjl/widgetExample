//
//  Utils.swift
//  Runner
//
//  Created by 雷子 on 2023/7/6.
//

import Foundation

func stringToMap(json: String?) -> [String: Any]? {
    guard let json = json else {
        return nil
    }
    if let data = json.data(using: .utf8),
       let map = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
        return map
    }
    return nil
}
