//
//  WeatherFeedWeatherFeedInteractorOutput.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

import Foundation

protocol WeatherFeedInteractorOutput: class {
    func didTriggerTimerOutput()

    func didObtainCities(_ cities: [CityPlainObject])
}
