//
//  WeatherFeedWeatherFeedViewInput.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

protocol WeatherFeedViewInput: class {

    /**
        @author trykov
        Setup initial state of the view
    */

    func setupInitialState()

    func configureWithItems(items: [WeatherFeedCellObject])
}
