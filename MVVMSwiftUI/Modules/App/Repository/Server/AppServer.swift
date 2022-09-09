//
//  AppServer.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation
import Combine

protocol AppServerProtocol {}

final class AppServer: Network, AppServer.ServerCalls {
    typealias ServerCalls = AppServerProtocol
}
