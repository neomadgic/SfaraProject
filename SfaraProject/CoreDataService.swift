//
//  CoreDataService.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/29/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {
    
    static var observationArray = CoreDataService()
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getObservationArray() -> [NSManagedObject] {
        
    }
}
