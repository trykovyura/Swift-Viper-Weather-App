//
// Created by Юрий Трыков on 02.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation

class WeatherFeedInitializer: NSObject {

    //Connect with object on storyboard

    @IBOutlet weak var weatherFeedViewController: WeatherFeedViewController!
    
    override func awakeFromNib() {

        let configurator = WeatherFeedConfigurator()
        configurator.configureModuleForViewInput(viewInput: weatherFeedViewController)
    }

}
