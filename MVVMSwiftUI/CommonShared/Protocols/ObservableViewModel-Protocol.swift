//
//  ObservableViewModel-Protocol.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

protocol ObservableViewModelProtocol {
    func onAppear()
    func onDisappear()
    func configureUI()
}
