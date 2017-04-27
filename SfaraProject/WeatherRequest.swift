//
//  WeatherRequest.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/27/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

/**
 *  Struct that builds the URL to send to the server for parsing. Call the getter to URL for the fully qualified URL
 */

struct WeatherRequest {
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
    
    init(zipCode: String) {
        self.zipCode = zipCode
    }
    
    func downloadCurrentWeather() {
        
        let task = URLSession.shared.dataTask(with: URL!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            let currentObservations = json["current_observation"] as! [String:Any]
            let displayLocation = currentObservations["display_location"] as! [String:Any]
            let location = displayLocation["full"] as! String
            let temperature = currentObservations["temp_f"] as! Double
            let forecast = currentObservations["weather"] as! String
            let dateAndTime = FormatPlaceHelper.currentDateAndTimeAsString()
            let temperatureAsString = FormatPlaceHelper.temperatureToString(from: temperature)
            
            print(location)
            print(temperature)
            print(forecast)
            print(dateAndTime)
            print(temperatureAsString)
            
        }
        
        task.resume()
    }
}
