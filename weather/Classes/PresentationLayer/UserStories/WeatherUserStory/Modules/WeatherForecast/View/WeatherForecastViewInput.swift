//
//  WeatherForecastWeatherForecastViewInput.swift
//  weather
//
//  Created by trykov on 26/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

protocol WeatherForecastViewInput: class {

    /**
        @author trykov
        Setup initial state of the view
    */

    func setupInitialState(_ city: CityPlainObject)

    func configureWithItems(_ items:[ForecastPlainObject])
}
