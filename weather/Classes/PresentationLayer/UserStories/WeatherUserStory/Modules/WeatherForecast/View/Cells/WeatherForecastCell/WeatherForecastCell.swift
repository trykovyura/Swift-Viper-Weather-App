//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import UIKit

class WeatherForecastCell: UITableViewCell {

    static var defaultHeight: CGFloat? {
        return 44
    }

    func configure(with cellObject: WeatherForecastCellObject) {
        textLabel!.text = cellObject.name
        detailTextLabel!.text = cellObject.weather
    }
}
