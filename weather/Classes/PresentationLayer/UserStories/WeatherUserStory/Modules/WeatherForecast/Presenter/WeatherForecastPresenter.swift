//
//  WeatherForecastWeatherForecastPresenter.swift
//  weather
//
//  Created by trykov on 26/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

class WeatherForecastPresenter: WeatherForecastModuleInput, WeatherForecastViewOutput, WeatherForecastInteractorOutput {

    weak var view: WeatherForecastViewInput!
    var interactor: WeatherForecastInteractorInput!
    var router: WeatherForecastRouterInput!

    var city: CityPlainObject!

    //MARK: WeatherForecastModuleInput

    func configure(with city: CityPlainObject) {
        self.city = city
    }

    //MARK: WeatherForecastViewOutput

    func viewIsReady() {
        view.setupInitialState(city)
        interactor.obtainForecast(city)
    }

    func didTriggerPullToRefresh() {
        interactor.obtainForecast(city)
    }

    //MARK: WeatherForecastInteractorOutput

    func didObtainForecast(_ forecast: [ForecastPlainObject]) {
        view.configureWithItems(forecast)
    }
}
