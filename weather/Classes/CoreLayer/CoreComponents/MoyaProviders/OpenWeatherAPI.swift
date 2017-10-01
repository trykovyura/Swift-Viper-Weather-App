//
// Created by Юрий Трыков on 04.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import Moya

public enum OpenWeatherAPI {
    static let apiKey = ""
    case cities([Int])
    case forecast(Int)
}

let provider = RxMoyaProvider<OpenWeatherAPI>(plugins: [NetworkLoggerPlugin()])

extension OpenWeatherAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "http://api.openweathermap.org/data/2.5")!
    }
    public var path: String {
        switch self {
        case .cities(_):
            return "/group"
        case .forecast(let cityId):
            return "/forecast"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var parameters: [String: Any]? {
        switch self {
        case .cities(let cityIds):
            return [
                "APPID": OpenWeatherAPI.apiKey,
                "id": cityIds.map {
                    String($0)
                }.joined(separator: ",")
            ]
        case .forecast(let cityId):
            return [
                "id": cityId,
                "APPID": OpenWeatherAPI.apiKey
            ]
        default:
            return nil
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    public var task: Task {
        return .request
    }
    public var validate: Bool {
        return false
    }
    public var sampleData: Data {
        switch self {
        case .cities(_):
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .forecast(let cityId):
            return "{\"login\": \"\(cityId)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        }
    }
}
