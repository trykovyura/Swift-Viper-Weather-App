//
// Created by Трыков Юрий on 2019-07-04.
// Copyright (c) 2019 trykov. All rights reserved.
//

import RxDataSources

struct ForecastSection {
    var items: [Item]
}

extension ForecastSection: SectionModelType {
    typealias Item = WeatherForecastCellObject

    init(original: ForecastSection, items: [Item]) {
        self = original
        self.items = items
    }
}
