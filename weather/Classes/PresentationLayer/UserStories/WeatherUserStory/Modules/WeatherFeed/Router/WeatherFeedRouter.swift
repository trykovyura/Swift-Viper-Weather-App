//
//  WeatherFeedWeatherFeedRouter.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

import ViperMcFlurry

class WeatherFeedRouter: WeatherFeedRouterInput {
    weak var transitionHandler: RamblerViperModuleTransitionHandlerProtocol!

    let feedToDetailSegue = "feedToDetailSegue"

    func openForecastModule(_ city: CityPlainObject) {
        transitionHandler.openModule!(usingSegue: feedToDetailSegue).thenChain { input in
            guard let input = input as? WeatherForecastModuleInput else {
                return nil
            }
            input.configure(with: city)
            return nil
        }
    }
}
