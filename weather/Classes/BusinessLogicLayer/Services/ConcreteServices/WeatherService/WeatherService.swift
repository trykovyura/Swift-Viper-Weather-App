//
// Created by Юрий Трыков on 30.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation

public protocol WeatherService {

    func filterCities(_ searchString: String, _ cities: [CityPlainObject]) -> [CityPlainObject]

}

class WeatherServiceImpl: WeatherService {
    func filterCities(_ searchString: String, _ cities: [CityPlainObject]) -> [CityPlainObject] {
        return cities.filter({ (city: CityPlainObject) -> Bool in
            return city.name.lowercased().range(of: searchString.lowercased()) != nil
        })
    }
}
