//
//  NetworkResponse.swift
//  AppClipMenu
//
//  Created by Bryan Caro on 28/7/22.
//  Copyright © 2022 Fractal Team. All rights reserved.
//

import Foundation

//  MARK: - Empty Response
class EmptyResponse: Decodable {}

//  MARK: - Error Response
struct ErrorResponse: Codable, Error {
    let errorMessage : String?
    let description  : String?
    let code         : Int?
}
