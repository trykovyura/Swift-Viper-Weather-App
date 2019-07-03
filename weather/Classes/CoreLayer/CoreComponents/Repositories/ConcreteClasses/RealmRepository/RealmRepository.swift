//
//  RealmRepository
//  prototypeLevelTravel
//
//  Created by Aleksandr Denisenko on 7/18/17.
//  Copyright © 2017 Aleksandr Denisenko. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmRepositoryError: Error {
    case castError
}

class RealmRepository<T>: Repository where T: RealmEntity, T: Object, T.EntityType: Entity {

    typealias RealmEntityType = T

    private let realm: Realm

    init() throws {
        self.realm = try Realm()
    }

    func save(item: T.EntityType) throws {
        try realm.write {
            guard let model = item.modelObject as? T else {
                throw RealmRepositoryError.castError
            }
            realm.add(model)
        }
    }

    func save(items: [T.EntityType]) throws {
        try realm.write {
            let models = items.compactMap { $0.modelObject as? T }
            realm.add(models, update: true)
        }
    }

    func update(block: @escaping () -> Void) throws {
        try realm.write {
            block()
        }
    }

    func delete(item: T.EntityType) throws {
        try realm.write {
            guard let model = item.modelObject as? T else {
                throw RealmRepositoryError.castError
            }
            realm.delete(model)
        }
    }

    func deleteAll() throws {
        try realm.write {
            realm.delete(realm.objects(T.self))
        }
    }

    func fetch(predicate: NSPredicate?, sorted: Sorted?) -> [T.EntityType] {
        var objects = realm.objects(T.self)

        if let predicate = predicate {
            objects = objects.filter(predicate)
        }

        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }

        return objects.compactMap {
            $0.plainObject
        }
    }

    func fetchAll() -> [T.EntityType] {
        return realm.objects(T.self).compactMap {
            $0.plainObject
        }
    }
}
