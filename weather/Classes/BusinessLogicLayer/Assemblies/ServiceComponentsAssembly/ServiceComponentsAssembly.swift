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

        container.register(WeatherService.self) { _ in
            WeatherServiceImpl()
        }.inObjectScope(.transient)

        container.register(WeatherNetworkService.self) { _ in
            WeatherNetworkServiceImpl()
        }.inObjectScope(.transient)

        container.register(WeatherRepositoryService.self) { _ in
            WeatherRepositoryServiceImpl()
        }.inObjectScope(.transient)

        container.register(WeatherFacade.self) { res in
            WeatherFacadeImpl(weatherService: res.resolve(WeatherService.self)!,
                    weatherNetworkService: res.resolve(WeatherNetworkService.self)!,
                    weatherRepositoryService: res.resolve(WeatherRepositoryService.self)!)
        }.inObjectScope(.transient)

    }
}
