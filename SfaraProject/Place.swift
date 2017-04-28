//
//  Place.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/26/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

class Place {
    
//    private(set) var location: String?
//    private(set) var temperature: String?
//    private(set) var forecast: String?
    private(set) var dateAndTime: String?
    private(set) var observation: Observation?
    private(set) var zipCode: String?
    
    init(zipCode: String) {
        self.zipCode = zipCode
    }
    
    func updateObservation(completed: @escaping () -> ()) {
        
        let requestWeather = WeatherRequest(zipCode: zipCode!)
        requestWeather.getObservation { (observationJSON) -> (Void) in
            
        }
        requestWeather.getObservation { (observationJSON) -> (Void) in
            let observation = Observation(observationJSON: observationJSON)
            print(observation?.location)
            self.observation = observation
            self.updateDateAndTime()
            completed()
        }
    }
    
    func updateDateAndTime() {
        self.dateAndTime = FormatPlaceHelper.currentDateAndTimeAsString()
    }
    
//    /**
//     *  Returns a string that includes both temperature and location
//     */
//    func displayTemperatureAndLocation() -> String {
//        guard self.location != nil && self.temperature != nil else {
//            return "Unable to location the date and time"
//        }
//        return "\(temperature!), \(location!)"
//    }
    
//    /**
//     *  Downloads the current temperature and saves the data
//     */
//    func downloadCurrentPlace(completed: @escaping () -> ()) {
//        
//        let task = URLSession.shared.dataTask(with: WeatherRequest(zipCode: zipCode!).URL!) { data, response, error in
//            
//            // exit function if error
//            guard error == nil else {
//                print(error!)
//                return
//            }
//            guard let data = data else {
//                print("Data is empty")
//                return
//            }
//            
//            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
//            
//            //Guard statements to ensure that there is value in the JSON data
//            guard let currentObservations = json["current_observation"] as? [String:Any] else { return }
//            guard let displayLocation = currentObservations["display_location"] as? [String:Any] else { return }
//            guard let location = displayLocation["full"] as! String? else { return }
//            guard let temperature = currentObservations["temp_f"] as? Double else { return }
//            guard let forecast = currentObservations["weather"] as? String else { return }
//            
//            //Convert format to String
//            let dateAndTime = FormatPlaceHelper.currentDateAndTimeAsString()
//            let temperatureAsString = FormatPlaceHelper.temperatureToString(from: temperature)
//            
//            //Set our data
//            self.location = location
//            self.temperature = temperatureAsString
//            self.dateAndTime = dateAndTime
//            self.forecast = forecast
//            DispatchQueue.main.async {
//                completed()
//            }
//        }
//        task.resume()
//    }
    
}
