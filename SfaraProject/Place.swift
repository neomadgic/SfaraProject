//
//  Place.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/26/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

struct Place {
    
    private(set) var location: String?
    private(set) var temperature: Double?
    private(set) var forecast: String?
    private(set) var time: String?
    private(set) var date: String?
    
    init() {
        
    }
    
    func displayLocationAndTime() -> String {
        guard self.time != nil && self.date != nil else {
            return "Unable to location the date and time"
        }
        return "\(date), \(time)"
    }
    
    func displayTemperatureAndLocation() -> String {
        guard self.location != nil && self.temperature != nil else {
            return "Unable to location the date and time"
        }
        return "\(temperature), \(location)"
    }
    
}
