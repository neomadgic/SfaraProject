//
//  ViewController.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/25/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit
import MapKit

public var numberOfCells = 5

class ViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var historyTableView: UITableView!
    
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
        updateTable()
    }
    
    func updateTable() {
        getZipcode { (zipcode) -> (Void) in
            ObservationRequest(with: zipcode).requestObservation(with: { (observation) -> (Void) in
                
                print(observation)
                self.addToObservationArray(the: observation)
                self.historyTableView.reloadData()
            })
        }
    }
    
    func addToObservationArray(the: [String:String]) {
        if UserDefaultManager.count >= numberOfCells {
            CoreDataService.observationArray.replaceObservation(with: the, at: UserDefaultManager.startingLocation)
            UserDefaultManager.count += 1
            UserDefaultManager.startingLocation += 1
        } else {
            CoreDataService.observationArray.addObservation(with: the)
            UserDefaultManager.count += 1
            UserDefaultManager.startingLocation += 1
        }
    }
}

// MARK: - CLLocationManager Extension to display current location of user on the map

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.requestAlwaysAuthorization()
        mapView.showsUserLocation = (status == .authorizedAlways)
    }
    
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
        
        var position = (numberOfCells - 1)
        if UserDefaultManager.startingLocation > 0 {
            position = (UserDefaultManager.startingLocation - 1)
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell {
            
            if position >= indexPath.row {
                cell.configureCell(with: CoreDataService.observationArray.getArray()[position - indexPath.row])
            } else {
                cell.configureCell(with: CoreDataService.observationArray.getArray()[position - indexPath.row + numberOfCells])
            }
            return cell
        } else {
            return HistoryCell()
        }
    }
}
