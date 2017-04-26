//
//  ViewController.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/25/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.requestAlwaysAuthorization()
        mapView.showsUserLocation = (status == .authorizedAlways)
        centerMapView()
    }
    
    //Center the MapView
    func centerMapView() {
        guard let location = locationManager.location else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 1200, 1200)
        mapView.setRegion(coordinateRegion, animated: false)
    }
}
