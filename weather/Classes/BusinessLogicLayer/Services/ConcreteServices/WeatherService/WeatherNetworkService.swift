//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import Moya
import RxSwift

public protocol WeatherNetworkService {

    func fetchCities(_ completion: @escaping ([CityPlainObject]?) -> Void)

    func fetchForecast(_ city: CityPlainObject, completion: @escaping ([ForecastPlainObject]?) -> Void)

}

class WeatherNetworkServiceImpl: WeatherNetworkService {

    private static let cityIds = [
        6077243, 524901, 5368361, 1835848, 3128760, 4180439,
        2147714, 264371, 1816670, 2643743, 3451190, 1850147
    ]

    let disposeBag = DisposeBag()

    let provider = MoyaProvider<OpenWeatherAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])

    func fetchCities(_ completion: @escaping ([CityPlainObject]?) -> Void) {
        provider.rx.request(.cities(WeatherNetworkServiceImpl.cityIds))
                .debug()
                .filterSuccessfulStatusCodes()
                .asObservable()
                .map([CityPlainObject].self, atKeyPath: "list")
                .observeOn(MainScheduler.instance)
                .subscribe(
                        onNext: { cities in
                            completion(cities)
                        },
                        onError: { error in
                            print(error.localizedDescription)
                        })
                .disposed(by: disposeBag)
    }

    func fetchForecast(_ city: CityPlainObject, completion: @escaping ([ForecastPlainObject]?) -> Void) {
        provider.rx.request(.forecast(city.id))
                .debug()
                .filterSuccessfulStatusCodes()
                .asObservable()
                .map([ForecastPlainObject].self, atKeyPath: "list")
                .observeOn(MainScheduler.instance)
                .subscribe(
                        onNext: { forecasts in
                            completion(forecasts)
                        },
                        onError: { error in
                            print(error.localizedDescription)
                        })
                .disposed(by: disposeBag)
    }

}
