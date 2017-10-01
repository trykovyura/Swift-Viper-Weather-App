//
// Created by Юрий Трыков on 02.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import Swinject

class WeatherForecastConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? WeatherForecastViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: WeatherForecastViewController) {
        let r = ApplicationAssembly.assembler.resolver as! Container

        let router = WeatherForecastRouter()
        router.transitionHandler = viewController

        let presenter = WeatherForecastPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = WeatherForecastInteractor()
        interactor.output = presenter
        interactor.weatherFacade = r.resolve(WeatherFacade.self)

        presenter.interactor = interactor
        viewController.output = presenter
    }
}