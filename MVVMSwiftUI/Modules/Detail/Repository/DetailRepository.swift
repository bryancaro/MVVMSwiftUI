//
//  DetailRepository.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

protocol DetailRepositoryProtocol: ViewModelDataManagerProtocol {}

class DetailRepository: ServerDataManager {
    private let server : DetailServer
    private let local  : DetailLocal
    
    init(server: DetailServer = DetailServer(),
         local: DetailLocal = DetailLocal()) {
        self.server = server
        self.local = local
    }
}

extension DetailRepository: DetailRepositoryProtocol {}
