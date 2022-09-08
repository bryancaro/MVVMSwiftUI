//
//  LocationWeather-Model.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

// MARK: - WeatherModel
struct LocationWeatherModel {
    let coord     : CoordModel
    let weather   : [WeatherModel]
    let base      : String
    let main      : MainModel
    let visibility: Int
    let wind      : WindModel
    let clouds    : CloudsModel
    let dt        : Int
    let sys       : SysModel
    let timezone  : Int
    let id        : Int
    let name      : String
    let cod       : Int
    
    init(_ response: LocationWeatherResponse) {
        self.coord      = CoordModel(response.coord)
        self.weather    = response.weather?.map({ WeatherModel($0) }) ?? [WeatherModel]()
        self.base       = response.base ?? ""
        self.main       = MainModel(response.main)
        self.visibility = response.visibility ?? 0
        self.wind       = WindModel(response.wind)
        self.clouds     = CloudsModel(response.clouds)
        self.dt         = response.dt ?? 0
        self.sys        = SysModel(response.sys)
        self.timezone   = response.timezone ?? 0
        self.id         = response.id ?? 0
        self.name       = response.name ?? ""
        self.cod        = response.cod ?? 0
    }
}

// MARK: - CloudsModel
struct CloudsModel {
    let all: Int
    
    init(_ response: CloudsResponse?) {
        self.all = response?.all ?? 0
    }
}

// MARK: - CoordModel
struct CoordModel {
    let lon: Double
    let lat: Double
    
    init(_ response: CoordResponse?) {
        self.lon = response?.lon ?? 0
        self.lat = response?.lat ?? 0
    }
}

// MARK: - MainModel
struct MainModel {
    let temp     : Double
    let feelsLike: Double
    let tempMin  : Double
    let tempMax  : Double
    let pressure : Int
    let humidity : Int
    
    init(_ response: MainResponse?) {
        self.temp      = response?.temp ?? 0
        self.feelsLike = response?.feelsLike ?? 0
        self.tempMin   = response?.tempMin ?? 0
        self.tempMax   = response?.tempMax ?? 0
        self.pressure  = response?.pressure ?? 0
        self.humidity  = response?.humidity ?? 0
    }
}

// MARK: - SysModel
struct SysModel {
    let type   : Int
    let id     : Int
    let country: String
    let sunrise: Int
    let sunset : Int
    
    init(_ response: SysResponse?) {
        self.type    = response?.type ?? 0
        self.id      = response?.id ?? 0
        self.country = response?.country ?? ""
        self.sunrise = response?.sunrise ?? 0
        self.sunset  = response?.sunset ?? 0
    }
}

// MARK: - WeatherModel
struct WeatherModel {
    let id                : Int
    let main              : String
    let weatherDescription: String
    let icon              : String
    
    init(_ response: WeatherResponse?) {
        self.id                 = response?.id ?? 0
        self.main               = response?.main ?? ""
        self.weatherDescription = response?.weatherDescription ?? ""
        self.icon               = response?.icon ?? ""
    }
}

// MARK: - WindModel
struct WindModel {
    let speed: Double
    let deg  : Int
    
    init(_ response: WindResponse?) {
        self.speed = response?.speed ?? 0
        self.deg   = response?.deg ?? 0
    }
}
