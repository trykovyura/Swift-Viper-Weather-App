//
//  WeatherFeedCell.swift
//  weather
//
//  Created by Юрий Трыков on 25.08.17.
//  Copyright © 2017 trykov. All rights reserved.
//

import Foundation
import TableKit

class WeatherFeedCell: UITableViewCell, ConfigurableCell {

    static var defaultHeight: CGFloat? {
        return 44
    }

    func configure(with cellObject: WeatherFeedCellObject) {
        textLabel?.text = cellObject.name
        detailTextLabel?.text = cellObject.weather
    }
}
