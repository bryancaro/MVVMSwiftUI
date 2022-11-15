//
//  NetworkEndpoint.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

struct Endpoint {
    var path       : String
    var queryItems : [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components        = URLComponents()
        components.scheme     = "https"
        components.host       = "api.openweathermap.org" // example: cloudfunctions.net
        components.path       = "/data/2.5" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var headers: [String: Any] {
        /*
         let user              = "some api security"
         let password          = "some api security"
         let credentialData    = "\(user):\(password)".data(using: String.Encoding.utf8)!
         let base64Credentials = credentialData.base64EncodedString(options: [])
         
         return ["Authorization": "Basic \(base64Credentials)"]
         */
        return [String: Any]()
    }
}
