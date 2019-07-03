//
//  WeatherFeedWeatherFeedPresenter.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

class WeatherFeedPresenter: WeatherFeedModuleInput, WeatherFeedViewOutput, WeatherFeedInteractorOutput {

    weak var view: WeatherFeedViewInput!
    var interactor: WeatherFeedInteractorInput!
    var router: WeatherFeedRouterInput!
    var cities: [CityPlainObject]!

    // MARK: - WeatherFeedViewOutput

    func viewIsReady() {
        view.setupInitialState()
        interactor.obtainCities()
    }

    func didTriggerViewWillAppear() {
        interactor.startTimer()
    }

    func didTriggerViewWillDisappear() {
        interactor.stopTimer()
    }

    func didTriggerPullToRefresh() {
        interactor.obtainCities()
    }

    func didTriggerSearchEvent(_ searchString: String) {
        var cities = self.cities
        if !searchString.isEmpty {
            cities = interactor.filterCities(searchString, cities!)
        }
        view.configureWithItems(items: buildItems(cities!))
    }

    func didTapCity(_ city: CityPlainObject) {
        router.openForecastModule(city)
    }

    // MARK: - WeatherFeedInteractorOutput

    func didTriggerTimerOutput() {
        interactor.obtainCities()
    }

    func didObtainCities(_ cities: [CityPlainObject]) {
        self.cities = cities
        view.configureWithItems(items: buildItems(cities))
    }

    // MARK: - Private Methods

    func buildItems(_ cities: [CityPlainObject]) -> [WeatherFeedCellObject] {
        var myArray = [WeatherFeedCellObject]()
        cities.forEach { (city) in
            myArray.append(WeatherFeedCellObject(id: city.id, name: city.name, weather: city.weather, city: city))
        }
        return myArray
    }
}
