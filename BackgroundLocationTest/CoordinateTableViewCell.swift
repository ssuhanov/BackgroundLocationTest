//
//  CoordinateTableViewCell.swift
//  BackgroundLocationTest
//
//  Created by Serge Sukhanov on 2/24/18.
//  Copyright © 2018 Serge Sukhanov. All rights reserved.
//

import UIKit

class CoordinateTableViewCell: UITableViewCell {
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var batteryPercentLabel: UILabel!
    
    func configure(coordinate: Coordinate?) {
        self.dateTimeLabel.text = coordinate?.dateTime
        self.latitudeLabel.text = coordinate?.latitude
        self.longitudeLabel.text = coordinate?.longitude
        self.batteryPercentLabel.text = "\(coordinate?.batteryPercent ?? "--")%"
    }
}
