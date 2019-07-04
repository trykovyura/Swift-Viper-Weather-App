//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

public protocol WeatherRepositoryServiceType {

    func cities() -> Observable<[CityPlainObject]>

    func saveCities(_ cities: [CityPlainObject]) -> Observable<[CityPlainObject]>
}

class WeatherRepositoryService: WeatherRepositoryServiceType {

    func cities() -> Observable<[CityPlainObject]> {
        guard let repository = try? RealmRepository<CityModelObject>() else {
            return Observable.error(RealmRepositoryError.createError)
        }
        return repository.fetchAll()
    }

    func saveCities(_ cities: [CityPlainObject]) -> Observable<[CityPlainObject]> {
        guard let repository = try? RealmRepository<CityModelObject>() else {
            return Observable.error(RealmRepositoryError.createError)
        }
        return repository.save(items: cities)
                .map { cities }
    }
}
