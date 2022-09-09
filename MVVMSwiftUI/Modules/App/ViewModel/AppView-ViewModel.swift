//
//  AppView-ViewModel.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 9/9/22.
//

import Foundation
import Combine

extension AppView {
    class ViewModel: ObservableViewModel, ObservableViewModelProtocol {
        enum AppActiveView {
            case loading
            case home
            case detail
        }
        
        //  MARK: - Published
        @Published var appActive: AppActiveView = .loading
        //  MARK: - API Cancellable
        //  MARK: - Constants
        private      var repository: AppRepositoryProtocol!
        private weak var callback  : ViewModelAlertProtocol?
        //  MARK: - Lifecycle
        init(_ isLoading: Bool = true, repository: AppRepositoryProtocol = AppRepository()) {
            print("[DEBUG]-[VIEWMODEL] [AppView]: [init]")
            super.init(isLoading)
            self.callback                    = self
            self.repository                  = repository
            self.repository.callbackDelegate = self.callback
            initData()
        }
        
        deinit {
            print("[DEBUG]-[VIEWMODEL] [AppView]: [deinit] [\(self)]")
            deinitData()
        }
        
        func onAppear() {
            print("[DEBUG]-[VIEWMODEL] [AppView]: [onAppear]")
            dismissLoading()
        }
        
        func onDisappear() {
            print("[DEBUG]-[VIEWMODEL] [AppView]: [onDisappear]")
        }
        //  MARK: - UI
        func configureUI() {
            print("[DEBUG]-[VIEWMODEL] [AppView]: [configureUI]")
        }
        //  MARK: - Actions
        func changeRootAction(_ view: AppActiveView) {
            appActive = view
        }
        //  MARK: - API Calls
        //  MARK: - Alerts
    }
}

//  MARK: - Memory Initializer and Release
extension AppView.ViewModel: ViewModelDataSourceProtocol {
    func initData() {
        
    }
    
    func deinitData() {
        
    }
}
