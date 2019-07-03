//
//  WeatherFeedWeatherFeedInteractor.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//
import RxSwift

class WeatherFeedInteractor: WeatherFeedInteractorInput, TimeoutServiceOutput {

    weak var output: WeatherFeedInteractorOutput!

    var timeoutService: TimeoutServiceType!
    var weatherFacade: WeatherFacadeType!
    let disposeBag = DisposeBag()

    // MARK: - WeatherFeedInteractorInput
    func startTimer() {
        timeoutService.startTimer(self)
    }

    func stopTimer() {
        timeoutService.stopTimer()
    }

    func obtainCities() {
        weatherFacade.cities()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] cities in
                    self?.output.didObtainCities(cities)
                })
                .disposed(by: disposeBag)
    }

    func filterCities(_ searchString: String, _ cities: [CityPlainObject]) -> [CityPlainObject] {
        return weatherFacade.filterCities(searchString, cities)
    }

    // MARK: - TimeoutServiceOutput
    func didTriggerTimer() {
        output.didTriggerTimerOutput()
    }
}
