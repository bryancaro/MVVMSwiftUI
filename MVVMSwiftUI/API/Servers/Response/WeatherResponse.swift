//
//  WeatherResponse.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

// MARK: - WeatherResponse
struct LocationWeatherResponse: Codable {
    let coord     : CoordResponse?
    let weather   : [WeatherResponse]?
    let base      : String?
    let main      : MainResponse?
    let visibility: Int?
    let wind      : WindResponse?
    let clouds    : CloudsResponse?
    let dt        : Int?
    let sys       : SysResponse?
    let timezone  : Int?
    let id        : Int?
    let name      : String?
    let cod       : Int?
}

// MARK: - CloudsResponse
struct CloudsResponse: Codable {
    let all: Int?
}

// MARK: - CoordResponse
struct CoordResponse: Codable {
    let lon: Double?
    let lat: Double?
}

// MARK: - MainResponse
struct MainResponse: Codable {
    let temp     : Double?
    let feelsLike: Double?
    let tempMin  : Double?
    let tempMax  : Double?
    let pressure : Int?
    let humidity : Int?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - SysResponse
struct SysResponse: Codable {
    let type   : Int?
    let id     : Int?
    let country: String?
    let sunrise: Int?
    let sunset : Int?
}

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let id                : Int?
    let main              : String?
    let weatherDescription: String?
    let icon              : String?
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - WindResponse
struct WindResponse: Codable {
    let speed: Double?
    let deg  : Int?
}
