//
// Created by Юрий Трыков on 30.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation

public protocol WeatherServiceType {

    func filterCities(_ searchString: String, _ cities: [CityPlainObject]) -> [CityPlainObject]

}

class WeatherService: WeatherServiceType {
    func filterCities(_ searchString: String, _ cities: [CityPlainObject]) -> [CityPlainObject] {
        return cities.filter({ (city: CityPlainObject) -> Bool in
            return city.name.lowercased().range(of: searchString.lowercased()) != nil
        })
    }
}
