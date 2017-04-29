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
        
        var observationArray = [NSManagedObject]()
        let moc = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Observation")
        
        //Set Observation Array as the core data object
        do {
            observationArray = try moc.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return observationArray
    }
    
    func addObservation(with: [String:String]) {
        
        let moc = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Observation", in: moc)!
        let observation = NSManagedObject(entity: entity, insertInto: moc)
        
        //Set Values
        observation.setValue(with["location"], forKey: "location")
        observation.setValue(with["forecast"], forKey: "forecast")
        observation.setValue(with["temperature"], forKey: "temperature")
        observation.setValue(with["dateAndTime"], forKey: "dateAndTime")
        
        // save
        save(context: moc)
    }
    
    func replaceObservation(with: [String:String], at: Int) {
        
        let moc = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Observation")
        let result = try? moc.fetch(fetchRequest)
        
        guard result?[at] != nil else {
            print("Got an error here")
            return
        }
        
        let observation = result![at]
        
        //set Values
        observation.setValue(with["location"], forKeyPath: "location")
        observation.setValue(with["forecast"], forKeyPath: "forecast")
        observation.setValue(with["temperature"], forKeyPath: "temperature")
        observation.setValue(with["dateAndTime"], forKeyPath: "dateAndTime")
        
        save(context: moc)
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("save")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
