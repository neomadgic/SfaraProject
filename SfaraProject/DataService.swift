//
//  DataService.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/28/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

class DataService {
    
    static var instance = DataService()
    private(set) var loadedSettings = Settings()
    
    func saveSettings(){
        let settingsData = NSKeyedArchiver.archivedData(withRootObject: loadedSettings)
        UserDefaults.standard.set(settingsData, forKey: keyFor.SETTINGS)
    }
    
    func loadSettings(){
        if let settingsData = UserDefaults.standard.object(forKey: keyFor.SETTINGS) as? NSData {
            if let theSetting = NSKeyedUnarchiver.unarchiveObject(with: settingsData as Data) as? Settings {
                self.loadedSettings = theSetting
            }
        }
    }
}
