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
        guard let container = ApplicationAssembly.assembler.resolver as? Container else {
            fatalError()
        }

        let router = WeatherForecastRouter()
        router.transitionHandler = viewController

        let presenter = WeatherForecastPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = WeatherForecastInteractor()
        interactor.output = presenter
        interactor.weatherFacade = container.resolve(WeatherFacade.self)

        presenter.interactor = interactor
        viewController.output = presenter
        viewController.moduleInput = presenter
    }
}
