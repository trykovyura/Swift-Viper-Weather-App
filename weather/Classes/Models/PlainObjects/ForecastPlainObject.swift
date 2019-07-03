//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import Mapper

public struct ForecastPlainObject: Mappable {
    let name: String
    let time: Int
    let day: String

    public init(map: Mapper) throws {
        try name = map.from("dt_txt")
        try time = map.from("dt")
        try day = map.from("weather", transformation: extractWeatherName)
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
