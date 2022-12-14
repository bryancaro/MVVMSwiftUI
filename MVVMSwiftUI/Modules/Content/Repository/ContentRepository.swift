//
//  ContentRepository.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

protocol ContentRepositoryProtocol: ViewModelDataManagerProtocol {
    func readLondonWeather(completion: @escaping(LocationWeatherModel) -> Void)
    func readLondonWeatherErrorMsg(completion: @escaping(LocationWeatherModel) -> Void)
    func getLondonWeatherAsyncAwait() async -> LocationWeatherModel?
}

class ContentRepository: ServerDataManager {
    private let server : ContentServer
    private let local  : ContentLocal
    
    init(server: ContentServer = ContentServer(),
         local: ContentLocal = ContentLocal()) {
        self.server = server
        self.local = local
    }
}

extension ContentRepository: ContentRepositoryProtocol {
    //  MARK: - Async Await
    func getLondonWeatherAsyncAwait() async -> LocationWeatherModel? {
        do {
            let response = try await server.getLondonWeatherAsyncAwait()
            let model    = LocationWeatherModel(response)
            return model
        } catch {
            await handleAlert(error: error)
            return nil
        }
    }
    
    //  MARK: - Combine
    func readLondonWeather(completion: @escaping(LocationWeatherModel) -> Void) {
        server.getLondonWeather { [weak self] result in
            do {
                try self?.handle {
                    let response = try result.get()
                    let model    = LocationWeatherModel(response)
                    completion(model)
                }
            } catch {
                let result = "default_error".localized
                self?.callbackDelegate?.defaultError(result)
            }
        }
    }
    
    func readLondonWeatherErrorMsg(completion: @escaping(LocationWeatherModel) -> Void) {
        server.getLondonWeatherErrorMsg { [weak self] result in
            do {
                try self?.handle {
                    let response = try result.get()
                    let model    = LocationWeatherModel(response)
                    completion(model)
                }
            } catch {
                let result = "default_error".localized
                self?.callbackDelegate?.defaultError(result)
            }
        }
    }
}
