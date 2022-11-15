//
//  DetailServer.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation
import Combine

protocol DetailServerProtocol {}

final class DetailServer: Network, DetailServer.ServerCalls {
    typealias ServerCalls = DetailServerProtocol
    
}
