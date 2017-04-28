//
//  Place.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/26/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

class Place {
    
    private(set) var dateAndTime: String?
    private(set) var observation: Observation?
    private(set) var zipCode: String?
    
    init(zipCode: String) {
        self.zipCode = zipCode
    }
    
    func updateObservation(completed: @escaping () -> ()) {
        
        let requestWeather = WeatherRequest(zipCode: zipCode!)
        requestWeather.getObservation { (observationJSON) -> (Void) in
            let observation = Observation(using: observationJSON)
            self.observation = observation
            self.updateDateAndTime()
            completed()
        }
    }
    
    func updateDateAndTime() {
        self.dateAndTime = FormatPlaceHelper.currentDateAndTimeAsString()
    }
    
}
