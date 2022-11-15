//
//  ServerManagerError.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 6/9/22.
//

import Foundation

enum ServerManagerError: Error, Equatable {
    case serverError(String)
    case checkAccessError(String)
    case clientError(String)
    case defaultError(String)
}

struct ServerManagerErrorHandler {
    private let serverError      = 500
    private let checkAccessError = 409
    
    //  MARK: - Validate Server Error
    func validate(error: Error?, responseData: Data?, statusCode: Int?) -> ServerManagerError? {
        if let err = error {
            return handle(err, responseData, statusCode)
        } else {
            return nil
        }
    }
    
    // MARK: - Error Handlers
    private func handle(_ error: Error?, _ responseData: Data?, _ statusCode: Int?) -> ServerManagerError {
        guard let _ = error else {
            return makeServerError(nil)
        }
        
        switch statusCode ?? serverError {
        case checkAccessError:
            return makeCheckAccessError(responseData)
        default:
            return makeClientError(responseData)
        }
    }
    
    //  MARK: - Default Error
    private func makeServerError(_ error: String?) -> ServerManagerError {
        let result = "default_error".localized
        return ServerManagerError.serverError(error ?? result)
    }
    
    //  MARK: - Response Error
    private func makeCheckAccessError(_ responseData: Data?) -> ServerManagerError {
        var result: String
        var responseError: ErrorResponse?
        
        if let data = responseData {
            let decoder = newJSONDecoder()
            do {
                
                if let jsonString = String(data: data, encoding: String.Encoding.utf8) {
                    print("[RESPONSE ERROR]:\(jsonString)")
                }
                responseError = try decoder.decode(ErrorResponse.self, from: data)
            } catch let error {
                print("[DECODE ERROR]:\(error)")
                return ServerManagerError.checkAccessError("default_error".localized)
            }
        }
        result = responseError?.errorMessage ?? "default_error".localized
        return ServerManagerError.checkAccessError(result)
    }
    
    private func makeClientError(_ responseData: Data?) -> ServerManagerError {
        var result: String
        var responseError: ErrorResponse?
        
        if let data = responseData {
            let decoder = newJSONDecoder()
            do {
                
                if let jsonString = String(data: data, encoding: String.Encoding.utf8) {
                    print("[RESPONSE ERROR]:\(jsonString)")
                }
                responseError = try decoder.decode(ErrorResponse.self, from: data)
            } catch let error {
                print("[DECODE ERROR]:\(error)")
                return ServerManagerError.checkAccessError("default_error".localized)
            }
        }
        result = responseError?.errorMessage ?? "default_error".localized
        return ServerManagerError.clientError(result)
    }
}
