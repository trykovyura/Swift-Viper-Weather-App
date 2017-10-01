//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import Swinject

class ServiceComponentsAssembly: Assembly {

    func assemble(container: Container) {
        container.register(TimeoutService.self) { _ in
            TimeoutServiceImpl()
        }.inObjectScope(.transient)

        container.register(WeatherService.self) { r in
            WeatherServiceImpl()
        }.inObjectScope(.transient)

        container.register(WeatherNetworkService.self) { r in
            WeatherNetworkServiceImpl()
        }.inObjectScope(.transient)

        container.register(WeatherRepositoryService.self) { r in
            WeatherRepositoryServiceImpl()
        }.inObjectScope(.transient)

        container.register(WeatherFacade.self) { r in
            WeatherFacadeImpl(weatherService: r.resolve(WeatherService.self)!,
                    weatherNetworkService: r.resolve(WeatherNetworkService.self)!,
                    weatherRepositoryService: r.resolve(WeatherRepositoryService.self)!)
        }.inObjectScope(.transient)

    }
}
