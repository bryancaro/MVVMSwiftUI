//
//  AppRepository.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

protocol AppRepositoryProtocol: ViewModelDataManagerProtocol {}

class AppRepository: ServerDataManager {
    private let server : AppServer
    private let local  : AppLocal
    
    init(server: AppServer = AppServer(),
         local: AppLocal = AppLocal()) {
        self.server = server
        self.local = local
    }
}

extension AppRepository: AppRepositoryProtocol {}
