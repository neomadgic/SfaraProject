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
        
        // Set the Labels
        dateLabel.text = with.dateAndTime
        temperatureCityLabel.text = with.displayTemperatureAndLocation()
        
        // Set the Image
        weatherImage.image = UIImage(named: "\(with.forecast)")
    }

}
