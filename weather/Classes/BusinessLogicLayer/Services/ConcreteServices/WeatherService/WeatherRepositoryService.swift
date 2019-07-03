//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import RealmSwift

public protocol WeatherRepositoryService {

    func queryCities() -> [CityPlainObject]

    func saveCities(_ cities: [CityPlainObject], completion: @escaping () -> Void)
}

class WeatherRepositoryServiceImpl: WeatherRepositoryService {

    func queryCities() -> [CityPlainObject] {
        do {
            let repository = try RealmRepository<CityModelObject>()
            return repository.fetchAll()
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }

    func saveCities(_ cities: [CityPlainObject], completion: @escaping () -> Void) {
        do {
            let repository = try RealmRepository<CityModelObject>()
            try repository.save(items: cities)
            completion()
        } catch let error {
            print(error.localizedDescription)
            completion()
        }

    }
}
