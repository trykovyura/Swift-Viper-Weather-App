//
//  RealmRepository
//  prototypeLevelTravel
//
//  Created by Aleksandr Denisenko on 7/18/17.
//  Copyright © 2017 Aleksandr Denisenko. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum RealmRepositoryError: Error {
    case castError
    case createError
}

class RealmRepository<T>: Repository where T: RealmEntity, T: Object, T.EntityType: Entity {

    typealias RealmEntityType = T

    private let realm: Realm

    init() throws {
        self.realm = try Realm()
    }

    func save(item: T.EntityType) -> Observable<Void> {
        return Observable.create { [realm] observer -> Disposable in
            do {
                try realm.write {
                    guard let model = item.modelObject as? T else {
                        observer.onError(RealmRepositoryError.castError)
                        return
                    }
                    realm.add(model)
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }

    }

    func save(items: [T.EntityType]) -> Observable<Void> {
        return Observable.create { [realm] observer -> Disposable in
            do {
                try realm.write {
                    let models = items.compactMap { $0.modelObject as? T }
                    realm.add(models, update: true)
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func update(block: @escaping () -> Void) throws {
        try realm.write {
            block()
        }
    }

    func delete(item: T.EntityType) -> Observable<Void> {
        return Observable.create { [realm] observer -> Disposable in
            do {
                try realm.write {
                    guard let model = item.modelObject as? T else {
                        observer.onError(RealmRepositoryError.castError)
                        return
                    }
                    realm.delete(model)
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }

    }

    func deleteAll() -> Observable<Void> {
        return Observable.create { [realm] observer -> Disposable in
            do {
                try realm.write {
                    realm.delete(realm.objects(T.self))
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }

    }

    func fetch(predicate: NSPredicate?, sorted: Sorted?) -> Observable<[T.EntityType]> {
        return Observable.create { [realm] observer -> Disposable in
            var objects = realm.objects(T.self)

            if let predicate = predicate {
                objects = objects.filter(predicate)
            }

            if let sorted = sorted {
                objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
            }

            let models: [T.EntityType] = objects.compactMap {
                $0.plainObject
            }
            observer.onNext(models)
            observer.onCompleted()
            return Disposables.create()
        }
    }

    func fetchAll() -> Observable<[T.EntityType]> {
        return Observable.create { [realm] observer -> Disposable in
            let results: [T.EntityType] = realm.objects(T.self).compactMap {
                $0.plainObject
            }
            observer.onNext(results)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
