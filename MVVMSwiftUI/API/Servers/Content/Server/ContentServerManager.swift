//
//  ContentServerManager.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation
import Combine

protocol ContentServerManagerProtocol: NetworkControllerProtocol {
    func getLondonWeather() -> AnyPublisher<LocationWeatherResponse, Error>
    func getLondonWeatherErrorMsg() -> AnyPublisher<LocationWeatherResponse, Error>
}

extension NetworkController: ContentServerManagerProtocol {
    func getLondonWeather() -> AnyPublisher<LocationWeatherResponse, Error> {
        let params    : [String: Any]  = [String: Any]()
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: "London,uk"),
            URLQueryItem(name: "APPID", value: "051683d80afc51c583b4310fe3c51220")
        ]
        
        let endpoint = Endpoint.londonWeather(queryItems)
        
        return request(.get,
                       type: LocationWeatherResponse.self,
                       url: endpoint.url,
                       headers: endpoint.headers,
                       params: params)
    }
    
    func getLondonWeatherErrorMsg() -> AnyPublisher<LocationWeatherResponse, Error> {
        let params    : [String: Any]  = [String: Any]()
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "--", value: "London,uk"),
            URLQueryItem(name: "APPID", value: "051683d80afc51c583b4310fe3c51220")
        ]
        
        let endpoint = Endpoint.londonWeather(queryItems)
        
        return request(.get,
                       type: LocationWeatherResponse.self,
                       url: endpoint.url,
                       headers: endpoint.headers,
                       params: params)
    }
}
