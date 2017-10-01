//
//  WeatherForecastWeatherForecastInteractor.swift
//  weather
//
//  Created by trykov on 26/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

class WeatherForecastInteractor: WeatherForecastInteractorInput {

    weak var output: WeatherForecastInteractorOutput!
    var weatherFacade: WeatherFacade!

    //MARK:WeatherForecastInteractorInput

    func obtainForecast(_ city: CityPlainObject) {
        weatherFacade.obtainForecast(city) { [weak self] forecast in
            self?.output.didObtainForecast(forecast as? [ForecastPlainObject] ?? [ForecastPlainObject]())
        }
    }
}
