//
//  ViewController.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/25/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var historyTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentPlace1 = Place(zipCode: "55379")
    var placeArray = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.instance.loadSettings()
        locationManager.delegate = self
    }
    
}

// MARK: - CLLocationManager Extension to display current location of user on the map

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.requestAlwaysAuthorization()
        mapView.showsUserLocation = (status == .authorizedAlways)
        centerMapView()
        addPlaceArray()
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
    
    func addPlaceArray() {
        getZipcode { (zipcode) -> (Void) in
            let request = ObservationRequest(zipCode: zipcode)
            request.requestObservation(with: { (json) -> (Void) in
                
                guard let observationDictionary = request.parseObservation(using: json) else {
                    print("Error retrieving parsed JSON data")
                    return
                }
                CoreDataService.observationArray.addObservation(with: observationDictionary)
                self.historyTableView.reloadData()
            })
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell {
            cell.configureCell(with: CoreDataService.observationArray.getArray()[indexPath.row])
            return cell
        } else {
            return HistoryCell()
        }
    }
}
