//
//  WeatherFeedWeatherFeedInteractor.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

class WeatherFeedInteractor: WeatherFeedInteractorInput, TimeoutServiceOutput {

    weak var output: WeatherFeedInteractorOutput!

    var timeoutService: TimeoutService!
    var weatherFacade: WeatherFacade!

    //MARK : WeatherFeedInteractorInput
    func startTimer() {
        timeoutService.startTimer(self)
    }

    func stopTimer() {
        timeoutService.stopTimer()
    }

    func obtainCities() {
        weatherFacade.obtainCities { [weak self] cities in
            if let cities = cities {
                self?.output.didObtainCities(cities)
            }
        }
    }

    func filterCities(_ searchString: String, _ cities: [CityPlainObject]) -> [CityPlainObject] {
        return weatherFacade.filterCities(searchString, cities)
    }

    //MARK : TimeoutServiceOutput
    func didTriggerTimer() {
        output.didTriggerTimerOutput()
    }
}
