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
        return Observable.create { observer -> Disposable in
            do {
                let repository = try RealmRepository<CityModelObject>()
                let values = repository.fetchAll()
                observer.onNext(values)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }

    }

    func saveCities(_ cities: [CityPlainObject]) -> Observable<[CityPlainObject]> {
        return Observable.create { observer -> Disposable in
            do {
                let repository = try RealmRepository<CityModelObject>()
                try repository.save(items: cities)
                observer.onNext(cities)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
