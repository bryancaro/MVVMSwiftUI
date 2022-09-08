//
//  NetworkController.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation
import Combine

class Network: NetworkProtocol {
    var manager: NetworkController = NetworkController()
}

class NetworkController: NetworkControllerProtocol {
    //  MARK: - Generic Error
    let genericError = NSError(domain: "", code: -1)
    
    //  MARK: - API Request Controller
    func request<T: Decodable>(_ method : HttpMethod,
                               type     : T.Type,
                               decoder  : JSONDecoder = newJSONDecoder(),
                               url      : URL,
                               headers  : Headers,
                               params   : [String: Any]?) -> AnyPublisher<T, Error> {
        let randomRequest   = "\(Int.random(in: 0 ..< 100))"
        var timeDateRequest = Date()
        
        print("[COMBINE][idRequest_\(randomRequest)][URL]: [\(url)]")
        print("[COMBINE][idRequest_\(randomRequest)][PARAMETERS]: [\(params ?? [String: Any]())]")
        
        var urlRequest        = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody   = params?.paramsEncoded()
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
        //  MARK: - Combine Events
            .handleEvents(receiveSubscription: { subscription in
                timeDateRequest = Date()
                print("[COMBINE][idRequest_\(randomRequest)][SUBSCRIPTION]")
            }, receiveOutput: { value in
                print("[COMBINE][idRequest_\(randomRequest)][OUTPUT] \(String(decoding: value.data, as: UTF8.self))")
            }, receiveCompletion: { value in
                print("[COMBINE][idRequest_\(randomRequest)][COMPLETION][TIME] \(Date().timeIntervalSince(timeDateRequest).milliseconds)ms")
            }, receiveCancel: {
                print("[COMBINE][idRequest_\(randomRequest)][CANCEL][TIME] \(Date().timeIntervalSince(timeDateRequest).milliseconds)ms")
            })
        //  MARK: - Map Error
            .mapError { error -> Error in
                print("[COMBINE][idRequest_\(randomRequest)][ERROR] \(error.localizedDescription)")
                
                return error
            }
        //  MARK: - Map Response
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse else {
                    throw self.genericError
                }
                
                do {
                    if T.Type.self == EmptyResponse.Type.self {
                        print("[COMBINE][idRequest_\(randomRequest)][PARSER]: EmptyResponse")
                        
                        return EmptyResponse() as! T
                    } else if response.statusCode >= 200 && response.statusCode < 206 {
                        let value = try decoder.decode(T.self, from: result.data)
                        print("[COMBINE][idRequest_\(randomRequest)][PARSER][OK]")
                        
                        return value
                    } else {
                        let errorValue = try decoder.decode(ErrorResponse.self, from: result.data)
                        
                        throw errorValue
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print("[COMBINE][idRequest_\(randomRequest)][DECODING-ERROR] \(context)")
                    
                    if response.statusCode == 200, let resultData = result.data as? T {
                        return resultData
                    }
                    
                    let errorValue = try decoder.decode(ErrorResponse.self, from: result.data)
                    
                    throw errorValue
                } catch let error {
                    print("[COMBINE][idRequest_\(randomRequest)][PARSER][KO] \(error)")
                    if let parsedError = ServerManagerErrorHandler().validate(error: error, responseData: result.data, statusCode: response.statusCode) {
                        throw parsedError
                    } else {
                        throw error
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
