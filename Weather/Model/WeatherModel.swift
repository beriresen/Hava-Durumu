//
//  WeatherModel.swift
//  Weather
//
//  Created by Berire Şen Ayvaz on 26.01.2023.
//

import Foundation

struct WeatherModel: Codable {
    var success: Bool?
    var city: String?
    var result: [WeatherList]?
    
    enum CodingKeys :String,CodingKey {
        case result = "result"
        case city = "city"
        case success = "success"
    }
}

struct WeatherList: Codable {
    var date, day: String?
    var icon: String?
    var description, status, degree, min: String?
    var max, night, humidity: String?
}

