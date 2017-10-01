//
//  WeatherForecastWeatherForecastViewOutput.swift
//  weather
//
//  Created by trykov on 26/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

protocol WeatherForecastViewOutput:PullToRefreshProtocol {

    /**
        @author trykov
        Notify presenter that view is ready
    */

    func viewIsReady()
}
