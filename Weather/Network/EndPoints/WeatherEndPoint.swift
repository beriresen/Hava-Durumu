//
//  WeatherEndPoint.swift
//  Weather
//
//  Created by Berire Şen Ayvaz on 25.01.2023.
//

import Alamofire

enum WeatherEndPoint{
    case weather(lang:String,city:String)
}

extension WeatherEndPoint:Endpoint{
    var path: String {
        switch self {
        case .weather:
            return "/weather/getWeather"

        }
    }
    var method: HTTPMethod {
        switch self {
        case .weather:
            return .get
        }
    }
    var param: [String : Any]? {
        switch self {
        case .weather(let lang, let city):
            return ["data.lang": lang,
                    "data.city": city]

        }
    }
    var header: HTTPHeaders {
      //  let accessToken = "jNl48pxho7lJvPw2WWizC3MzxYh5VMtu17dLcyeGcjy5LliVT120rkd0g3Lh"
        switch self {
        case .weather:
            return [
                "Content-Type":"application/json",
                "Authorization":"apikey 4nroiqqRh3zJKOdp5ZIuTR:76OCJsC7h1fFo0HrMkgz02"
              //  "Authorization": "Bearer API KEY \(accessToken)"
            ]
        }
    }
    var body: [String: String]? {
        switch self {
        case .weather:
            return nil
        }
    }
}
