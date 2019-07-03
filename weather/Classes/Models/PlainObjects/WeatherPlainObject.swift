//
// Created by Трыков Юрий on 2019-07-03.
// Copyright (c) 2019 trykov. All rights reserved.
//

import Foundation

struct WeatherPlainObject {
  let id: Int
  let main: String
  let description: String
  let icon: String
}

extension WeatherPlainObject: Codable {

    enum WeatherPlainObjectKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: WeatherPlainObjectKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(main, forKey: .main)
        try container.encode(description, forKey: .description)
        try container.encode(icon, forKey: .icon)
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherPlainObjectKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        main = try container.decode(String.self, forKey: .main)
        description = try container.decode(String.self, forKey: .description)
        icon = try container.decode(String.self, forKey: .icon)
    }
}
