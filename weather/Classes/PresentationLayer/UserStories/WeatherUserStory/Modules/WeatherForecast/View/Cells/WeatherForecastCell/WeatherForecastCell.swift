//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import TableKit

class WeatherForecastCell: UITableViewCell, ConfigurableCell {

    static var defaultHeight: CGFloat? {
        return 44
    }

    func configure(with cellObject: WeatherForecastCellObject) {
        textLabel!.text = cellObject.name
        detailTextLabel!.text = cellObject.weather
    }
}