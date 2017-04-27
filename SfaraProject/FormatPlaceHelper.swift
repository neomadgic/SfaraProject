//
//  FormatPlaceHelper.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/27/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

class FormatPlaceHelper {
    
    static func temperatureToString(from: Double) -> String {
        
        //Round the temperature
        var roundedTemperature = from
        roundedTemperature.round()
        
        // get temperature with no decimal
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
    
    static func modifyForecast(from: String) -> String {
        switch from {
        case "Mostly Sunny", "Partly Sunny", "Intermittent Clouds", "Clear", "Mostly Clear":
            return "Sunny"
        case "Mostly Cloudy":
            return "Cloudy"
        case "Showers", "Mostly Cloudy w/ Showers", "Partly Sunny w/ Showers":
            return "Rain"
        case "Flurries", "Mostly Cloudy w/ Flurries", "Partly Sunny w/ Flurries", "Mostly Cloudy w/ Snow", "Ice", "Sleet", "Freezing Rain", "Rain and Snow":
            return "Snow"
        case "Mostly Cloudy w/ T-Storms", "Partly Cloudy w/ T-Storms":
            return "T-Storms"
        default:
            return from
        }
    }
}
