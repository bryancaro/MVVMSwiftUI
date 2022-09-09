//
//  DetailView-ViewModel.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 9/9/22.
//

import Foundation
import Combine

extension DetailView {
    class ViewModel: ObservableViewModel, ObservableViewModelProtocol {
        //  MARK: - Published
        //  MARK: - API Cancellable
        //  MARK: - Constants
        private      var repository: DetailRepositoryProtocol!
        private weak var callback  : ViewModelAlertProtocol?
        //  MARK: - Lifecycle
        init(_ isLoading: Bool = true, repository: DetailRepositoryProtocol = DetailRepository()) {
            print("[DEBUG]-[VIEWMODEL] [DetailView]: [init]")
            super.init(isLoading)
            self.callback                    = self
            self.repository                  = repository
            self.repository.callbackDelegate = self.callback
            initData()
        }
        
        deinit {
            print("[DEBUG]-[VIEWMODEL] [DetailView]: [deinit] [\(self)]")
            deinitData()
        }
        
        func onAppear() {
            print("[DEBUG]-[VIEWMODEL] [DetailView]: [onAppear]")
            dismissLoading()
        }
        
        func onDisappear() {
            print("[DEBUG]-[VIEWMODEL] [DetailView]: [onDisappear]")
        }
        //  MARK: - UI
        func configureUI() {
            print("[DEBUG]-[VIEWMODEL] [DetailView]: [configureUI]")
        }
        //  MARK: - Actions
        //  MARK: - API Calls
        //  MARK: - Alerts
    }
}

//  MARK: - Memory Initializer and Release
extension DetailView.ViewModel: ViewModelDataSourceProtocol {
    func initData() {
        
    }
    
    func deinitData() {
        
    }
}
