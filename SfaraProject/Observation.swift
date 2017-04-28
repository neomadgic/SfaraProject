//
//  Observation.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/28/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation
import UIKit

class Observation {
    
    private(set) var location: String?
    private(set) var temperature: String?
    private(set) var forecast: String?
    private(set) var observationJSON: [String:Any]
    
    required init?(observationJSON: [String:Any]) {
        self.observationJSON = observationJSON
        getObservation()
    }
    
    func getObservation() {
        print("Did we make it here?")
        
        //Guard to make sure we get data is found within the json
        guard let currentObservations = observationJSON["current_observation"] as? [String:Any], let displayLocation = currentObservations["display_location"] as? [String:Any], let location = displayLocation["full"] as! String?, let temperature = currentObservations["temp_f"] as? Double, let forecast = currentObservations["weather"] as? String else {
            print("Unabled to retrieve observations")
            return
        }
        
        self.location = location
        self.temperature = FormatPlaceHelper.temperatureToString(from: temperature)
        self.forecast = forecast
    }
    
//    func getObservation(json: [String:Any]) {
//        
        //Guard to make sure we get data is found within the json
//        guard let currentObservations = json["current_observation"] as? [String:Any], let displayLocation = currentObservations["display_location"] as? [String:Any], let location = displayLocation["full"] as! String?, let temperature = currentObservations["temp_f"] as? Double, let forecast = currentObservations["weather"] as? String else {
//            print("Unabled to retrieve observations")
//            return
//        }
//        
//        self.location = location
//        self.temperature = FormatPlaceHelper.temperatureToString(from: temperature)
//        self.forecast = forecast
//    }
    
}
