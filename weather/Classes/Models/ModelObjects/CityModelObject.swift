//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import RealmSwift

class CityModelObject: Object, RealmEntity {

    typealias EntityType = CityPlainObject

    dynamic var id = 0
    dynamic var name = ""
    dynamic var weather = ""
    dynamic var created = Date()

    convenience required init(entity: EntityType) {
        self.init()
        self.id = entity.id
        self.name = entity.name
        self.weather = entity.weather
        self.created = Date()
    }

    var plainObject: CityPlainObject {
        return CityPlainObject(id: id, name: name, weather: weather)
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
