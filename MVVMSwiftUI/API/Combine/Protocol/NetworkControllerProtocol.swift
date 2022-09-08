//
//  NetworkControllerProtocol.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation
import Combine

protocol NetworkProtocol {
    var manager: NetworkController { get }
}

protocol NetworkControllerProtocol: AnyObject {
    typealias Headers = [String: Any]
    
    func request<T>(_ method : HttpMethod,
                    type     : T.Type,
                    decoder  : JSONDecoder,
                    url      : URL,
                    headers  : Headers,
                    params   : [String: Any]?
    ) -> AnyPublisher<T, Error> where T: Decodable
}

enum HttpMethod: String{
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}
