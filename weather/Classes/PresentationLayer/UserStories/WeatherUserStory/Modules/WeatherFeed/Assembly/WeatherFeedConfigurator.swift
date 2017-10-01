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
        let r = ApplicationAssembly.assembler.resolver as! Container

        let router = WeatherFeedRouter()
        router.transitionHandler = viewController

        let presenter = WeatherFeedPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = WeatherFeedInteractor()
        interactor.output = presenter
        interactor.timeoutService = r.resolve(TimeoutService.self)
        interactor.weatherFacade = r.resolve(WeatherFacade.self)

        presenter.interactor = interactor
        viewController.output = presenter
    }
}