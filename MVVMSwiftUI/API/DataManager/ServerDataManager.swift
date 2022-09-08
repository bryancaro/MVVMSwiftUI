//
//  ServerDataManager.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

class ServerDataManager {
    weak var callbackDelegate: ViewModelAlertProtocol?
    
    convenience init(delegate: ViewModelAlertProtocol?) {
        self.init()
        self.callbackDelegate = delegate
    }
    
    func handle<T>(result: Result<T, Error>, completion: @escaping Handler<T>) {
        do {
            try self.handle {
                let value = try result.get()
                DispatchQueue.main.async {
                    completion(value)
                }
            }
        } catch let error {
            let result = error.localizedDescription//"default.error.message"
            self.callbackDelegate?.defaultError(result)
        }
    }
    
    func handle(f: () throws -> Void) throws {
        do {
            try f()
        } catch ServerManagerError.serverError(let message) {
            self.callbackDelegate?.serverError(message)
        } catch ServerManagerError.clientError(let message) {
            self.callbackDelegate?.defaultError(message)
        } catch ServerManagerError.checkAccessError(let message) {
            self.callbackDelegate?.defaultError(message)
        } catch let error {
            throw error
        }
    }
    
    deinit {
        print("deinit \(self)")
    }
}
