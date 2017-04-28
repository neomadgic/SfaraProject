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

class WeatherRequest {
    
    typealias ObservationCompletionHandlerType = ([String:Any])->(Void)
    
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
    
    func getObservation(with completionHandler: @escaping ObservationCompletionHandlerType) {
        
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

            let observation = json
//            print(observation)
//            print("we made it here at least")
            DispatchQueue.main.async {
                completionHandler(observation)
            }
        }
        task.resume()
    }
    
//    /**
//     *  Downloads the current temperature and saves the data
//     */
//    func downloadCurrentPlace(completed: @escaping () {
//        
//        let task = URLSession.shared.dataTask(with: URL!) { data, response, error in
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
//            DispatchQueue.main.async {
//                completed()
//            }
//        }
//        task.resume()
//    }
}
