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
        private      var repository: ContentRepositoryProtocol!
        private weak var callback  : ViewModelAlertProtocol?
        //  MARK: - Lifecycle
        init(_ isLoading: Bool = true, repository: ContentRepositoryProtocol = ContentRepository()) {
            print("[DEBUG]-[VIEWMODEL] [ContentView]: [init]")
            super.init(isLoading)
            self.callback                    = self
            self.repository                  = repository
            self.repository.callbackDelegate = self.callback
            initData()
        }
        
        deinit {
            print("[DEBUG]-[VIEWMODEL] [ContentView]: [deinit] [\(self)]")
            deinitData()
        }
        
        func onAppear() {
            print("[DEBUG]-[VIEWMODEL] [ContentView]: [onAppear]")
            dismissLoading()
        }
        
        func onDisappear() {
            print("[DEBUG]-[VIEWMODEL] [ContentView]: [onDisappear]")
        }
        //  MARK: - UI
        func configureUI() {
            print("[DEBUG]-[VIEWMODEL] [ContentView]: [configureUI]")
        }
        
        func configureLondonWeather(_ londonWeather: LocationWeatherModel) {
            self.londonWeather = londonWeather
            dismissLoading()
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
                self?.configureLondonWeather(londonWeather)
            }
        }
        
        private func readErrorLondonWeather() {
            showLoading()
            repository.readLondonWeatherErrorMsg { [weak self] londonWeather in
                self?.configureLondonWeather(londonWeather)
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
