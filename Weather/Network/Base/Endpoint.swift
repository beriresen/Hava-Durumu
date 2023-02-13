//
//  Endpoint.swift
//  Weather
//
//  Created by Berire Şen Ayvaz on 25.01.2023.
//

import Alamofire

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var param: [String: Any]? { get }
    var header: HTTPHeaders { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.collectapi.com"
    }
}
