//
//  Settings.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/28/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

class Settings: NSObject, NSCoding {
    
    var place = [Place?](repeating: nil, count:5)
    var startingLocation = 0
    var count = 0
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.place = (aDecoder.decodeObject(forKey: keyFor.PLACEARRAY) as? [Place?])!
        self.startingLocation = (aDecoder.decodeObject(forKey: keyFor.STARTINGLOCATION) as? Int)!
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.place, forKey: keyFor.PLACEARRAY)
        coder.encode(self.startingLocation, forKey: keyFor.STARTINGLOCATION)
    }
    
    func add(Place: Place, at: Int) {
        
    }
}
