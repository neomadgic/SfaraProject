//
//  FormatWeather.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/27/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

class FormatPlaceHelper {
    
    static func temperatureToString(from: Double) -> String {
        
        var roundedTemperature = from
        roundedTemperature.round()
        
        return "\(Int(roundedTemperature))˚"
    }
    
    static func currentDateAndTimeAsString() -> String {
        
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        
        // get the date time String from the date object
        return formatter.string(from: currentDateTime)
    }
}
