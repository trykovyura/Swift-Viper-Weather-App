//
//  WeatherForecastWeatherForecastInteractorInput.swift
//  weather
//
//  Created by trykov on 26/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

import Foundation

protocol WeatherForecastInteractorInput {

    func obtainForecast(_ city: CityPlainObject)
}
