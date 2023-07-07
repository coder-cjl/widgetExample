//
//  DefaultUtils.swift
//  Runner
//
//  Created by 雷子 on 2023/7/6.
//

import Foundation

class DefaultUtils {
    static let share = DefaultUtils()
    
    private let userDefalut = UserDefaults(suiteName: "group.com.example.flutterUiExample1")
    
    func set(value: Any, forKey: String) {
        userDefalut?.set(value, forKey: forKey)
    }
    
    func getString(forKey: String) -> String? {
        userDefalut?.string(forKey: forKey)
    }
    
    func get(forKey: String) -> Any? {
       return userDefalut?.object(forKey: forKey)
    }
    
    func getArray(forKey: String) -> [Any]? {
        return userDefalut?.array(forKey: forKey)
    }
    
    func getDictionary(forKey: String) -> [String: Any]? {
        return userDefalut?.dictionary(forKey: forKey)
    }
}
