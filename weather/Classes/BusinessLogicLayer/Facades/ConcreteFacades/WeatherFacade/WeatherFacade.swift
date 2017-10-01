//
// Created by Юрий Трыков on 30.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation

public protocol WeatherFacade {

    func obtainCities(_ completion: @escaping ([CityPlainObject]?) -> ())

    func obtainForecast(_ city: CityPlainObject, completion: @escaping ([ForecastPlainObject]?) -> ())

    func filterCities(_ searchString: String, _ cities: [CityPlainObject]) -> [CityPlainObject]
}

class WeatherFacadeImpl: WeatherFacade {

    private let weatherService: WeatherService
    private let weatherNetworkService: WeatherNetworkService
    private let weatherRepositoryService: WeatherRepositoryService

    // MARK: - Init

    init(weatherService: WeatherService,
         weatherNetworkService: WeatherNetworkService,
         weatherRepositoryService: WeatherRepositoryService) {

        self.weatherService = weatherService
        self.weatherNetworkService = weatherNetworkService
        self.weatherRepositoryService = weatherRepositoryService
    }

    func obtainCities(_ completion: @escaping ([CityPlainObject]?) -> ()) {
        let cities = self.weatherRepositoryService.queryCities()
        if !cities.isEmpty {
            DispatchQueue.main.async {
                completion(cities)
            }
        } else {
            weatherNetworkService.fetchCities { [weak self] cities in
                if let cities = cities {
                    self?.weatherRepositoryService.saveCities(cities) {
                        if let cities = self?.weatherRepositoryService.queryCities() {
                            DispatchQueue.main.async {
                                completion(cities)
                            }
                        }
                    }
                }
            }
        }
    }

    func obtainForecast(_ city: CityPlainObject, completion: @escaping ([ForecastPlainObject]?) -> ()) {
        weatherNetworkService.fetchForecast(city, completion: completion)
    }

    func filterCities(_ searchString: String, _ cities: [CityPlainObject]) -> [CityPlainObject] {
        return weatherService.filterCities(searchString, cities)
    }
}