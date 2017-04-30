//
//  HistoryCell.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/25/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit
import CoreData

class HistoryCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureCityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with: NSManagedObject) {
        
        // Ensure that the Observation has values
        guard let location = with.value(forKey: "location") as? String, let temperature = with.value(forKey: "temperature") as? String, let forecast = with.value(forKey: "forecast") as? String, let dateAndTime = with.value(forKey: "dateAndTime") as? String else {
            print("Error with location or temperature")
            return
        }
        
        //Set the Labels
        dateLabel.text = dateAndTime
        temperatureCityLabel.text = "\(temperature), \(location)"
        weatherImage.image = UIImage(named: "\(FormatPlaceHelper.modifyForecast(from: forecast))")
    }
}
