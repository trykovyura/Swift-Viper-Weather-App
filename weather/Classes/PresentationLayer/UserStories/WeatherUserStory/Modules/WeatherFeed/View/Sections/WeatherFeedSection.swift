//
// Created by Трыков Юрий on 2019-07-04.
// Copyright (c) 2019 trykov. All rights reserved.
//

import RxDataSources

struct WeatherFeedSection {
    var items: [Item]
}

extension WeatherFeedSection: SectionModelType {
    typealias Item = WeatherFeedCellObject

    init(original: WeatherFeedSection, items: [Item]) {
        self = original
        self.items = items
    }
}
