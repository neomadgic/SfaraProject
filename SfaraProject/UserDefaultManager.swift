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
            if newValue < numberOfCells {
                UserDefaults.standard.set(newValue, forKey: countKey)
            } else {
                UserDefaults.standard.set(numberOfCells, forKey: countKey)
            }
            
        }
    }
    
    static var startingLocation: Int {
        get {
            return UserDefaults.standard.integer(forKey: startingLocationKey)
        }
        set {
            if newValue > (numberOfCells - 1) {
                UserDefaults.standard.set(0, forKey: startingLocationKey)
            } else {
                UserDefaults.standard.set(newValue, forKey: startingLocationKey)
            }
        }
    }
}
