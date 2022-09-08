//
//  ViewModelDataSource.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

protocol ViewModelDataSourceProtocol {
    //  MARK: - LifeCycle
    func initData()

    func deinitData()
}
