//
// Created by Юрий Трыков on 04.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation

// implemented by your immutable structs
protocol Entity {
    associatedtype RealmEntityType
    var modelObject: RealmEntityType { get }
}

// Implemented by RealmSwift.Object subclasses
protocol RealmEntity {
    associatedtype EntityType

    var plainObject: EntityType { get }
}
