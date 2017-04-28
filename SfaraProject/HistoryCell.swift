//
//  HistoryCell.swift
//  SfaraProject
//
//  Created by Vu Dang on 4/25/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureCityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with: Place) {
        
        // Ensure that the Place has values
        guard let location = with.observation?.location, let temperature = with.observation?.temperature, let forecast = with.observation?.forecast else {
            print("Error with location or temperature")
            return
        }
        
        // Set the Labels
        dateLabel.text = with.dateAndTime
        temperatureCityLabel.text = "\(temperature), \(location)"
        weatherImage.image = UIImage(named: "\(FormatPlaceHelper.modifyForecast(from: forecast))")
    }
}
