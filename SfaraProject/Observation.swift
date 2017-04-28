//
//  Observation.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/28/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

    /**
    *  Observation class has the location, temperature, and forecast.
    *  in tandem with the observationRequest class, it downloads the location, temperature, and forecast
    */

class Observation {
    
    private(set) var location: String?
    private(set) var temperature: String?
    private(set) var forecast: String?
    
    required init?(using: [String:Any]) {
        getObservation(with: using)
    }
    
    func getObservation(with: [String:Any]) {
        
        //Guard to make sure we get data is found within the json
        guard let currentObservations = with["current_observation"] as? [String:Any], let displayLocation = currentObservations["display_location"] as? [String:Any], let location = displayLocation["full"] as! String?, let temperature = currentObservations["temp_f"] as? Double, let forecast = currentObservations["weather"] as? String else {
            print("Unabled to retrieve observations")
            return
        }
        
        self.location = location
        self.temperature = FormatPlaceHelper.temperatureToString(from: temperature)
        self.forecast = forecast
    }
    
}
