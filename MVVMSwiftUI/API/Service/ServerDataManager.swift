//
//  ServerDataManager.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

class ServerDataManager {
    weak var callbackDelegate: ViewModelAlertProtocol?
    
    convenience init(delegate: ViewModelAlertProtocol?) {
        self.init()
        self.callbackDelegate = delegate
    }
    
    //  MARK: - Async Await
    func handleAlert(error: Error) async {
        if let error = error as? NetworkError {
            switch error {
            case .invalidURL, .noResponse, .unknown:
                self.callbackDelegate?.defaultError("default.error.message".localized)
            case .decode(let message):
                self.callbackDelegate?.defaultError(message)
            case .noInternet(let message):
                self.callbackDelegate?.defaultError(message)
            case .serverError(let message):
                self.callbackDelegate?.serverError(message)
            }
        } else {
            self.callbackDelegate?.defaultError("default.error.message".localized)
        }
    }
    
    //  MARK: - Combine
    func handle<T>(result: Result<T, Error>, completion: @escaping Handler<T>) {
        do {
            try self.handle {
                let value = try result.get()
                DispatchQueue.main.async {
                    completion(value)
                }
            }
        } catch let error {
            let result = error.localizedDescription//"default.error.message"
            self.callbackDelegate?.defaultError(result)
        }
    }
    
    func handle(f: () throws -> Void) throws {
        do {
            try f()
        } catch ServerManagerError.serverError(let message) {
            self.callbackDelegate?.serverError(message)
        } catch ServerManagerError.clientError(let message) {
            self.callbackDelegate?.defaultError(message)
        } catch ServerManagerError.checkAccessError(let message) {
            self.callbackDelegate?.defaultError(message)
        } catch let error {
            throw error
        }
    }
    
    deinit {
        print("deinit \(self)")
    }
}

/*
 class NetworkDataManager {
     weak var callbackDelegate: ViewModelAlertProtocol?
     
     convenience init(delegate: ViewModelAlertProtocol?) {
         self.init()
         self.callbackDelegate = delegate
     }
     
     func handleAlert(error: Error) async {
         if let error = error as? NetworkError {
             switch error {
             case .invalidURL, .noResponse, .unknown:
                 self.callbackDelegate?.defaultErrorAlert("default.error.message".localized)
             case .decode(let message):
                 self.callbackDelegate?.defaultErrorAlert(message)
             case .noInternet(let message):
                 self.callbackDelegate?.noInternetErrorAlert(message)
             case .serverError(let message):
                 self.callbackDelegate?.serverErrorAlert(message)
             }
         } else {
             self.callbackDelegate?.defaultErrorAlert("default.error.message".localized)
         }
     }
     
     deinit {
         print("deinit \(self)")
     }
 }

 */
