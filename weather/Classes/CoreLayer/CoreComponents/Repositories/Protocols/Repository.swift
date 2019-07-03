//
// Created by Юрий Трыков on 04.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation

struct Sorted {
    var key: String
    var ascending: Bool = true
}

protocol Repository: class {
    associatedtype EntityType
    /*
     Save an item
     */
    func save(item: EntityType) throws

    /*
    Save an array of items
     */
    func save(items: [EntityType]) throws

    /*
     Update an item
     */
    func update(block: @escaping () -> Void) throws

    /*
     Delete an item
     */
    func delete(item: EntityType) throws

    /*
     Delete all items
     */
    func deleteAll() throws

    /*
     Return a list of items
     */
    func fetch(predicate: NSPredicate?, sorted: Sorted?) -> [EntityType]

    /*
     Return list of all items
     */
    func fetchAll() -> [EntityType]
}
