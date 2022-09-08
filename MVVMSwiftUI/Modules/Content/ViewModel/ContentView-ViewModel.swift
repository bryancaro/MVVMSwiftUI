//
//  ContentView-ViewModel.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation
import Combine

extension ContentView {
    class ViewModel: ObservableViewModel, ObservableViewModelProtocol {
        //  MARK: - Published
        @Published var showDetail   : Bool = false
        @Published var londonWeather: LocationWeatherModel?
        //  MARK: - API Cancellable
        //  MARK: - Constants
        private var repository: ContentRepositoryProtocol!
        private var callback  : ViewModelAlertProtocol!
        //  MARK: - Lifecycle
        override init() {
            super.init()
            print("[DEBUG]-[VIEWMODEL] []: [init]")
            self.callback                    = self
            self.repository                  = ContentRepository()
            self.repository.callbackDelegate = self.callback
            initData()
        }
        
        deinit {
            print("[DEBUG]-[VIEWMODEL] []: [deinit]")
            deinitData()
        }
        
        func onAppear() {
            print("[DEBUG]-[VIEWMODEL] []: [onAppear]")
            dismissLoading()
        }
        
        func onDisappear() {
            print("[DEBUG]-[VIEWMODEL] []: [onDisappear]")
        }
        //  MARK: - UI
        func configureUI() {
            print("[DEBUG]-[VIEWMODEL] []: [configureUI]")
        }
        //  MARK: - Actions
        func getLondonWeatherAction() {
            readLondonWeather()
        }
        
        func getErrorLondonWeatherAction() {
            readErrorLondonWeather()
        }
        
        func readEnvironment() {
            print(ConfigReader.environment())
        }
        
        func openDetailAction() {
            showDetail = true
        }
        
        func closeDetailAction() {
            showDetail = false
        }
        
        override func dismissAlertAction() {
            isLoading = false
        }
        
        //  MARK: - API Calls
        private func readLondonWeather() {
            showLoading()
            repository.readLondonWeather { [weak self] londonWeather in
                print(londonWeather)
                self?.londonWeather = londonWeather
                self?.dismissLoading()
            }
        }
        
        private func readErrorLondonWeather() {
            showLoading()
            repository.readLondonWeatherErrorMsg { [weak self] londonWeather in
                print(londonWeather)
                self?.londonWeather = londonWeather
                self?.dismissLoading()
            }
        }
        //  MARK: - Alerts
        override func defaultError(_ errorString: String) {
            haptic(type: .warning)
            appError = AppError(errorString: errorString)
        }
    }
}

//  MARK: - Memory Initializer and Release
extension ContentView.ViewModel: ViewModelDataSourceProtocol {
    func initData() {
        
    }
    
    func deinitData() {
        
    }
}
