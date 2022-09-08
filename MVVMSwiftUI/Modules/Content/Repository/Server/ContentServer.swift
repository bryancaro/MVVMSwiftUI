//
//  ContentServer.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation
import Combine

protocol ContentServerProtocol {
    func getLondonWeather(completion: @escaping(Result<LocationWeatherResponse, Error>) -> Void)
    func getLondonWeatherErrorMsg(completion: @escaping(Result<LocationWeatherResponse, Error>) -> Void)
}

final class ContentServer: Network, ContentServer.ServerCalls {
    typealias ServerCalls = ContentServerProtocol
    
    private var cancellableGetLondonWeather: Cancellable?
    private var cancellableGetLondonWeatherErrorMsg: Cancellable?
    
    func getLondonWeather(completion: @escaping(Result<LocationWeatherResponse, Error>) -> Void) {
        cancellableGetLondonWeather = manager.getLondonWeather()
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("[DEBUG] [API] [getLondonWeather] [FINISHED]")
                case .failure(let error):
                    print("[DEBUG] [API] [getLondonWeather] [ERROR] [\(error.localizedDescription)]")
                    completion(Result.failure(error))
                }
            }, receiveValue: { response in
                print("[DEBUG] [API] [getLondonWeather] [RESPONSE]")
                completion(Result.success(response))
            })
    }
    
    func getLondonWeatherErrorMsg(completion: @escaping(Result<LocationWeatherResponse, Error>) -> Void) {
        cancellableGetLondonWeatherErrorMsg = manager.getLondonWeatherErrorMsg()
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("[DEBUG] [API] [getLondonWeather] [FINISHED]")
                case .failure(let error):
                    print("[DEBUG] [API] [getLondonWeather] [ERROR] [\(error.localizedDescription)]")
                    completion(Result.failure(error))
                }
            }, receiveValue: { response in
                print("[DEBUG] [API] [getLondonWeather] [RESPONSE]")
                completion(Result.success(response))
            })
    }
}
