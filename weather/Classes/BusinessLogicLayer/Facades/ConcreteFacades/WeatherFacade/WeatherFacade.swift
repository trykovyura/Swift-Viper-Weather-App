//
// Created by Юрий Трыков on 30.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import RxSwift

public protocol WeatherFacadeType {

    func cities() -> Observable<[CityPlainObject]>

    func forecasts(_ city: CityPlainObject) -> Observable<[ForecastPlainObject]>

    func filterCities(_ searchString: String, _ cities: [CityPlainObject]) -> [CityPlainObject]
}

class WeatherFacade: WeatherFacadeType {

    private let weatherService: WeatherServiceType
    private let weatherNetworkService: WeatherNetworkServiceType
    private let weatherRepositoryService: WeatherRepositoryServiceType

    // MARK: - Init

    init(weatherService: WeatherServiceType,
         weatherNetworkService: WeatherNetworkServiceType,
         weatherRepositoryService: WeatherRepositoryServiceType) {
        self.weatherService = weatherService
        self.weatherNetworkService = weatherNetworkService
        self.weatherRepositoryService = weatherRepositoryService
    }

    func cities() -> Observable<[CityPlainObject]> {
        let networkCities = weatherNetworkService.cities()
                .flatMap(weatherRepositoryService.saveCities)

        return weatherRepositoryService.cities()
                .flatMap { cities -> Observable<[CityPlainObject]> in
                    guard !cities.isEmpty else {
                        return networkCities
                    }
                    return Observable.just(cities)
                }
    }

    func forecasts(_ city: CityPlainObject) -> Observable<[ForecastPlainObject]> {
        return weatherNetworkService.forecasts(city)
    }

    func filterCities(_ searchString: String, _ cities: [CityPlainObject]) -> [CityPlainObject] {
        return weatherService.filterCities(searchString, cities)
    }
}
