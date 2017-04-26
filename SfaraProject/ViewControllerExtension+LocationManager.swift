//
//  ViewControllerExtension+LocationManager.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/25/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation
import MapKit


/**

 This delegate handles user's authenication of using their location.
 
 Afterwards, this delegate will set the location and center the mapview
 
 */

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .authorizedAlways)
        setCurrentLocation()
        centerMapView(with: currentLocation)
    }
    
    //Set Current Location
    func setCurrentLocation() {
        locationManager.requestAlwaysAuthorization()
        guard locationManager.location != nil else {
            print("Can't find location")
            return
        }
        currentLocation = locationManager.location!
    }
    
    //Center the MapView
    func centerMapView(with: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(with.coordinate, 1200, 1200)
        mapView.setRegion(coordinateRegion, animated: false)
    }
}
