//
//  WeatherFeedWeatherFeedViewOutput.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

protocol WeatherFeedViewOutput:PullToRefreshProtocol {

    /**
        @author trykov
        Notify presenter that view is ready
    */

    func viewIsReady()
    func didTriggerViewWillAppear()
    func didTriggerViewWillDisappear()

    func didTriggerSearchEvent(_ searchString: String)

    func didTapCity(_ city: CityPlainObject)
}
