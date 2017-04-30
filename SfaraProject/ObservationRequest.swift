//
//  ObservationRequest.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/27/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

/**
 *  This class handles all the web requesting and parsing the data into the right format
 */

class ObservationRequest {
    
    typealias ObservationCompletionHandlerType = ([String:String])->(Void)
    
    /// API Key to be used in the application
    private let APIKey = "189b51bbd050fc21"
    
    /// The zip code to send to the server.
    var zipCode: String
    
    var URL: Foundation.URL? {
        get {

            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.wunderground.com"
            urlComponents.path = "/api/\(APIKey)/conditions/hourly/q/\(zipCode).json"
            
            return urlComponents.url
        }
    }
    
    init(with: String) {
        self.zipCode = with
    }
    
    func requestObservation(with completionHandler: @escaping ObservationCompletionHandlerType) {
        
        let task = URLSession.shared.dataTask(with: URL!) { data, response, error in
            
            // exit function if error
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            DispatchQueue.main.async {
                completionHandler(self.parseObservation(using: json))
            }
        }
        task.resume()
    }
    
    func parseObservation(using: [String:Any]) -> [String:String] {
        
        //Guard to make sure we get data is found within the json
        guard let currentObservations = using["current_observation"] as? [String:Any], let displayLocation = currentObservations["display_location"] as? [String:Any], let location = displayLocation["full"] as! String?, let temperature = currentObservations["temp_f"] as? Double, let forecast = currentObservations["weather"] as? String else {
            print("Unabled to retrieve observations")
            // Return empty dictionary if fail
            return [
                "location": "",
                "temperature": "",
                "forecast": "",
                "dateAndTime": ""
            ]
        }
        
        // Set observation into the right dictionary format
        let observations: [String:String] = [
            "location": "\(location)",
            "temperature": "\(FormatPlaceHelper.temperatureToString(from: temperature))",
            "forecast": "\(forecast)",
            "dateAndTime": "\(FormatPlaceHelper.currentDateAndTimeAsString())"
        ]
        
        return observations
    }
}
