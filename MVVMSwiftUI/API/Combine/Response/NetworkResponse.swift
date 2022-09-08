//
//  NetworkResponse.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

//  MARK: - Empty Response
class EmptyResponse: Decodable {}

//  MARK: - Generic Server Error Response
struct ErrorResponse: Codable, Error {
    let errorMessage : String?
    let description  : String?
    let code         : Int?
    let cod          : String?
    let message      : String?
}
