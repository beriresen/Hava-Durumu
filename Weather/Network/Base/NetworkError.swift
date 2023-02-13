//
//  NetworkError.swift
//  Weather
//
//  Created by Berire Şen Ayvaz on 25.01.2023.
//

import Foundation
enum NetworkError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
