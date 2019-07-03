//
// Created by Юрий Трыков on 26.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation

public struct CityPlainObject {

    let id: Int
    let name: String
    let weather: String

    public init(id: Int, name: String, weather: String) {
        self.id = id
        self.name = name
        self.weather = weather
    }

}

extension CityPlainObject: Codable {

    enum CityPlainObjectKeys: String, CodingKey {
        case id
        case name
        case weather
    }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CityPlainObjectKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(weather, forKey: .weather)
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CityPlainObjectKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let weathers: [WeatherPlainObject] = try container.decode([WeatherPlainObject].self, forKey: .weather)
        weather = weathers.first?.main ?? ""
    }

}

extension CityPlainObject: Entity {

    typealias RealmEntityType = CityModelObject

    var modelObject: CityModelObject {
        return CityModelObject(entity: self)
    }
}
