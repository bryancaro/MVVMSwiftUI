//
//  Content-Endpoint.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

extension Endpoint {
    static var londonWeather = { (queryItems: [URLQueryItem]) -> Self in
        return Endpoint(path: "/weather", queryItems: queryItems)
    }
}
