//
//  Place.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/26/17.
//  Copyright © 2017 Vu Dang. All rights reserved.


import Foundation

    /**
    * A Place class has a date and time, observation, and zipcode.
    * Observation class contains location, forecast, and temperature of the place
    */

class Place {
    
    private(set) var dateAndTime: String?
    //private(set) var observation: Observation?
    private(set) var zipCode: String?
    
    init(zipCode: String) {
        self.zipCode = zipCode
    }
    
    func updatePlace(completed: @escaping () -> ()) {
        
        let requestObservation = ObservationRequest(zipCode: zipCode!)
        requestObservation.requestObservation { (observationJSON) -> (Void) in
            //let observation = Observation(using: observationJSON)
            //self.observation = observation
            self.updateDateAndTime()
            completed()
        }
    }
    
    func updateDateAndTime() {
        self.dateAndTime = FormatPlaceHelper.currentDateAndTimeAsString()
    }
    
}
