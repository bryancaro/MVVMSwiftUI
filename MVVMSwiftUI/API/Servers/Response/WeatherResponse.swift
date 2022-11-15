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

extension LocationWeatherResponse {
    static let empty  = LocationWeatherResponse(coord: nil, weather: nil, base: nil, main: nil, visibility: nil, wind: nil, clouds: nil, dt: nil, sys: nil, timezone: nil, id: nil, name: nil, cod: nil)
    static let mockUp = LocationWeatherResponse(coord: CoordResponse.mockUp, weather: [WeatherResponse.mockUp], base: "Aus", main: MainResponse.mockUp, visibility: 15, wind: WindResponse.mockUp, clouds: CloudsResponse.mockUp, dt: 55, sys: SysResponse.mockUp, timezone: 24, id: 5, name: "Name locarion", cod: 5)
}

// MARK: - CloudsResponse
struct CloudsResponse: Codable {
    let all: Int?
}

extension CloudsResponse {
    static let empty  = CloudsResponse(all: nil)
    static let mockUp = CloudsResponse(all: 1)
}

// MARK: - CoordResponse
struct CoordResponse: Codable {
    let lon: Double?
    let lat: Double?
}

extension CoordResponse {
    static let empty  = CoordResponse(lon: nil, lat: nil)
    static let mockUp = CoordResponse(lon: 4.525, lat: -72.3262)
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

extension MainResponse {
    static let empty  = MainResponse(temp: nil, feelsLike: nil, tempMin: nil, tempMax: nil, pressure: nil, humidity: nil)
    static let mockUp = MainResponse(temp: 25, feelsLike: 20, tempMin: 15, tempMax: 26, pressure: 55, humidity: 100)
}

// MARK: - SysResponse
struct SysResponse: Codable {
    let type   : Int?
    let id     : Int?
    let country: String?
    let sunrise: Int?
    let sunset : Int?
}

extension SysResponse {
    static let empty  = SysResponse(type: nil, id: nil, country: nil, sunrise: nil, sunset: nil)
    static let mockUp = SysResponse(type: 5, id: 1, country: "USA", sunrise: 20, sunset: 12)
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

extension WeatherResponse {
    static let empty  = WeatherResponse(id: nil, main: nil, weatherDescription: nil, icon: nil)
    static let mockUp = WeatherResponse(id: 0, main: "Main title", weatherDescription: "Its very hot", icon: "arrow")
}

// MARK: - WindResponse
struct WindResponse: Codable {
    let speed: Double?
    let deg  : Int?
}

extension WindResponse {
    static let empty  = WindResponse(speed: nil, deg: nil)
    static let mockUp = WindResponse(speed: 10.50, deg: 25)
}
