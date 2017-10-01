//
// Created by Юрий Трыков on 26.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import Mapper

public struct CityPlainObject: Mappable, Entity {

    typealias RealmEntityType = CityModelObject

    let id: Int
    let name: String
    let weather: String

    public init(id: Int, name: String, weather: String) {
        self.id = id
        self.name = name
        self.weather = weather
    }

    public init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
        try weather = map.from("weather", transformation: extractWeatherName)
    }

    var modelObject: CityModelObject {
        return CityModelObject(entity: self)
    }
}

private func extractWeatherName(object: Any?) throws -> String {
    guard let weatherArray = object as? [Any] else {
        throw MapperError.convertibleError(value: object, type: [Any].self)
    }
    guard let weatherDic = weatherArray[0] as? [String: Any] else {
        throw MapperError.convertibleError(value: object, type: [String: Any].self)
    }
    guard let main = weatherDic["main"] as? String else {
        throw MapperError.convertibleError(value: object, type: String.self)
    }
    return main
}
