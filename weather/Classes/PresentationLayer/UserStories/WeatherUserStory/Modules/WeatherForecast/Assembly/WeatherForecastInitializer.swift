//
// Created by Юрий Трыков on 02.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation

class WeatherForecastInitializer: NSObject {

    //Connect with object on storyboard

    @IBOutlet weak var weatherForecastViewController: WeatherForecastViewController!

    override func awakeFromNib() {

        let configurator = WeatherForecastConfigurator()
        configurator.configureModuleForViewInput(viewInput: weatherForecastViewController)
    }

}