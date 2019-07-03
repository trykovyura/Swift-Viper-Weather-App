//
//  WeatherForecastWeatherForecastInteractor.swift
//  weather
//
//  Created by trykov on 26/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//
import RxSwift

class WeatherForecastInteractor: WeatherForecastInteractorInput {

    weak var output: WeatherForecastInteractorOutput!
    var weatherFacade: WeatherFacadeType!

    let disposeBag = DisposeBag()

    // MARK: - WeatherForecastInteractorInput

    func obtainForecast(_ city: CityPlainObject) {
        weatherFacade.forecasts(city)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] forecast in
                    self?.output.didObtainForecast(forecast)
                })
                .disposed(by: disposeBag)
    }
}
