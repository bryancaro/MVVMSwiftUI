//
//  ObservableViewModel.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation
import Combine

class ObservableViewModel: ObservableObject, ViewModelAlertProtocol {
    //  MARK: - Published
    @Published var isLoading: Bool      = true
    @Published var appError : AppError? = nil
    //  MARK: - Constants
    //  MARK: - UI
    func showLoading()  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            self.isLoading = true
        }
    }
    
    func dismissLoading()  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            self.isLoading = false
        }
    }
    
    //  MARK: - Alerts
    func dismissAlertAction() {
        print("[DEBUG]-[] []: Dismiss Alert")
    }
    
    //  MARK: - Alerts
    func defaultError(_ errorString: String) {
        haptic(type: .error)
        appError = AppError(errorString: errorString)
    }
    
    func serverError(_ errorString: String) {
        haptic(type: .error)
        appError = AppError(errorString: errorString)
    }
    
    func noInternetError(_ errorString: String) {
        haptic(type: .error)
        appError = AppError(errorString: errorString)
    }
}
