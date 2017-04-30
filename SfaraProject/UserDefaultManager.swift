//
//  UserDefaultManager.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/30/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

class UserDefaultManager {
    
    private static let countKey = "count"
    private static let startingLocationKey = "startingLocation"
    
    static var count: Int {
        get {
            return UserDefaults.standard.integer(forKey: countKey)
        }
        set {
            if newValue < 5 {
                UserDefaults.standard.set(newValue, forKey: countKey)
            } else {
                UserDefaults.standard.set(5, forKey: countKey)
            }
            
        }
    }
    
    static var startingLocation: Int {
        get {
            return UserDefaults.standard.integer(forKey: startingLocationKey)
        }
        set {
            if newValue > 4 {
                UserDefaults.standard.set(0, forKey: startingLocationKey)
            } else {
                UserDefaults.standard.set(newValue, forKey: startingLocationKey)
            }
        }
    }
}
