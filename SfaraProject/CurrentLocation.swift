//
//  CurrentLocation.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/28/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct CurrentLocation {
    private(set) var zipCode: String?
    
    init(with: CLLocationManager) {
        getZipcode()
    }
    
    func getZipcode() {
        
    }
}
