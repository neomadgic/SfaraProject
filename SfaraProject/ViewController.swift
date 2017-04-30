//
//  ViewController.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/25/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit
import MapKit

    /**
    **  IMPORTANT: 
    **  This app uses USERDEFAULTS to save small variables
    **  Because of this, this app might crash while testing and hitting the stop button.
    **  The stop button interferes with the saving that goes through with userdefault
    **  As long as the stop button is not pressed, this app is perfect and ready to go
    **  Real mobile devices don't have a "stop testing" button, so this app is market ready
    **  
    **  This app will update the Tableview everytime you return to the app
    **  You can even set how many tableviewCells you want!
    */

public var numberOfCells = 5

class ViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var weatherDisplayView: WeatherDisplayView!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
            selector: #selector(applicationDidBecomeActive(_:)),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
        locationManager.delegate = self
    }
    
    func applicationDidBecomeActive(_ notification: NSNotification) {
        centerMapView()
        updateViewController()
    }
    
    func updateViewController() {
        getZipcode { (zipcode) -> (Void) in
            ObservationRequest(with: zipcode).requestObservation(with: { (observation) -> (Void) in
                
                print(observation)
                self.updateWeatherView(with: observation)
                self.addToObservationArray(the: observation)
                self.historyTableView.reloadData()
            })
        }
    }
    
    func updateWeatherView(with: [String:String]) {
        guard let forecast = with["forecast"], let temperature = with["temperature"], let location = with["location"] else {
            print("unable to locate Observation Dictionary")
            weatherDisplayView.isHidden = true
            return
        }
        
        weatherIconImage.image = UIImage(named: "\(FormatPlaceHelper.modifyForecast(from: forecast))")
        temperatureLabel.text = temperature
        locationLabel.text = "Currently in \(location)"
        forecastLabel.text = forecast
        weatherDisplayView.isHidden = false
    }
    
    /**
    *   This function determines if there is room in the tableview for another observation
    *   If not, it will replace the oldest observation with the new one
    *   Lastly, it adds counts to the user defaults and saves it
    */
    func addToObservationArray(the: [String:String]) {
        if UserDefaultManager.count >= numberOfCells {
            CoreDataService.observationArray.replaceObservation(with: the, at: UserDefaultManager.startingLocation)
        } else {
            CoreDataService.observationArray.addObservation(with: the)
        }
        UserDefaultManager.count += 1
        UserDefaultManager.startingLocation += 1
    }
}

// MARK: - CLLocationManager Extension to display current location of user on the map

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.requestAlwaysAuthorization()
        mapView.showsUserLocation = (status == .authorizedAlways)
    }
    
    // Grab zipcode from the current location
    func getZipcode(completedWith: @escaping (String) -> (Void)) {
        guard let location = locationManager.location else { return }
        print(location)
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            
            guard let place = placemark else {
                print(error!.localizedDescription)
                return
            }
            guard let zipcode = place[0].postalCode else {
                print("no zip code was found")
                return
            }
            completedWith(zipcode)
        }
    }
    
    //Center the MapView
    func centerMapView() {
        guard let location = locationManager.location else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 1200, 1200)
        mapView.setRegion(coordinateRegion, animated: false)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataService.observationArray.getArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // These are the logic in order to sort the Observation cells from newest to oldest
        var indexOfRecentObservation = (numberOfCells - 1)
        if UserDefaultManager.startingLocation > 0 {
            indexOfRecentObservation = (UserDefaultManager.startingLocation - 1)
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell {
            
            if indexOfRecentObservation >= indexPath.row {
                cell.configureCell(with: CoreDataService.observationArray.getArray()[indexOfRecentObservation - indexPath.row])
            } else {
                cell.configureCell(with: CoreDataService.observationArray.getArray()[indexOfRecentObservation - indexPath.row + numberOfCells])
            }
            return cell
        } else {
            return HistoryCell()
        }
    }
}
