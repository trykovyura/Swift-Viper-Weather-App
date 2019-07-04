//
//  WeatherFeedWeatherFeedInteractorInput.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

import Foundation

protocol WeatherFeedInteractorInput {

    func obtainCities()

    func filterCities(_ searchString: String, _ cities: [CityPlainObject]) -> [CityPlainObject]

    func startTimer()

    func stopTimer()
}
