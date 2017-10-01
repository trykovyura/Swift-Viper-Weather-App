//
//  WeatherFeedWeatherFeedRouter.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//
import LightRoute

class WeatherFeedRouter: WeatherFeedRouterInput {
    weak var transitionHandler: TransitionHandler!

    let feedToDetailSegue = "feedToDetailSegue"

    func openForecastModule(_ city: CityPlainObject) {
        transitionHandler.forSegue(identifier: feedToDetailSegue, to:WeatherForecastModuleInput.self) { (moduleInput) in
             moduleInput.configure(with:city)
        }
    }
}
