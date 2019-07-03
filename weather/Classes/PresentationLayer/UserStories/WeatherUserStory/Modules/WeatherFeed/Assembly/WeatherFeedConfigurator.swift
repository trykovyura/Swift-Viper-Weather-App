//
// Created by Юрий Трыков on 02.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import Swinject

class WeatherFeedConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? WeatherFeedViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: WeatherFeedViewController) {
        guard let container = ApplicationAssembly.assembler.resolver as? Container else {
            fatalError()
        }

        let router = WeatherFeedRouter()
        router.transitionHandler = viewController

        let presenter = WeatherFeedPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = WeatherFeedInteractor()
        interactor.output = presenter
        interactor.timeoutService = container.resolve(TimeoutService.self)
        interactor.weatherFacade = container.resolve(WeatherFacade.self)

        presenter.interactor = interactor
        viewController.output = presenter
    }
}
