//
//  ViewModelAlert-Protocol.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

typealias VoidHandler = () -> Void
typealias Handler<T> = (T) -> Void

protocol ViewModelAlertProtocol: AnyObject {
    func defaultError(_ errorString: String)
    func serverError(_ errorString: String)
    func noInternetError(_ errorString: String)
}

