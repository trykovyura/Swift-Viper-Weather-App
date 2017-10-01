//
//  RealmRepository
//  prototypeLevelTravel
//
//  Created by Aleksandr Denisenko on 7/18/17.
//  Copyright © 2017 Aleksandr Denisenko. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRepository<T>: Repository where T: RealmEntity, T: Object, T.EntityType: Entity {
    
    typealias RealmEntityType = T

    private let realm = try! Realm()

    func save(item: T.EntityType) throws {
        try realm.write {
            realm.add(item.modelObject as! T)
        }
    }

    func save(items: [T.EntityType]) throws {
        try realm.write {
            items.forEach {
                realm.add($0.modelObject as! T, update: true)
            }
        }
    }

    func update(block: @escaping () -> ()) throws {
        try realm.write() {
            block()
        }
    }

    func delete(item: T.EntityType) throws {
        try realm.write() {
            realm.delete(item.modelObject as! T)
        }
    }

    func deleteAll() throws {
        try realm.write() {
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

        return objects.flatMap {
            $0.plainObject
        }
    }

    func fetchAll() -> [T.EntityType] {
        return realm.objects(T.self).flatMap {
            $0.plainObject
        }
    }
}
