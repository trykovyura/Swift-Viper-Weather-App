//
// Created by Юрий Трыков on 04.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import RxSwift

struct Sorted {
    let key: String
    let ascending: Bool = true
}

protocol Repository {
    associatedtype EntityType
    /*
     Save an item
     */
    func save(item: EntityType) -> Observable<Void>

    /*
    Save an array of items
     */
    func save(items: [EntityType]) -> Observable<Void>

    /*
     Update an item
     */
    func update(block: @escaping () -> Void) throws

    /*
     Delete an item
     */
    func delete(item: EntityType) -> Observable<Void>

    /*
     Delete all items
     */
    func deleteAll() -> Observable<Void>

    /*
     Return a list of items
     */
    func fetch(predicate: NSPredicate?, sorted: Sorted?) -> Observable<[EntityType]>

    /*
     Return list of all items
     */
    func fetchAll() -> Observable<[EntityType]>
}
