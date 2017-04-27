//
//  Place.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/26/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

struct Place {
    
    private(set) var location: String
    private(set) var temperature: String
    private(set) var forecast: String
    private(set) var dateAndTime: String
    
    init(location: String, temperature: String, forecast: String, dateAndTime: String) {
        self.location = location
        self.temperature = temperature
        self.forecast = forecast
        self.dateAndTime = dateAndTime
    }
    
    // Return temperature and Location
    func displayTemperatureAndLocation() -> String {
//        guard self.location != nil && self.temperature != nil else {
//            return "Unable to location the date and time"
//        }
        return "\(temperature), \(location)"
    }
    
}
