//
//  ContentView.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import SwiftUI

struct ContentView: View {
    //  MARK: - Environment
    @EnvironmentObject var appEnvironment: AppView.ViewModel
    //  MARK: - Observed Object
    @StateObject private var viewModel = ViewModel()
    //  MARK: - Binding variables
    //  MARK: - State variables
    //  MARK: - Constant variables
    //  MARK: - Properties
    //  MARK: - Initializer View
    init() {}
    //  MARK: - Principal View
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    VStack {
                        HStack {
                            Button(action: viewModel.getLondonWeatherAction) {
                                Text("Success API Call")
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(15)
                            }
                            .accessibilityIdentifier("SuccessAPIButton")
                            
                            Button(action: viewModel.getErrorLondonWeatherAction) {
                                Text("Error API Call")
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(15)
                            }
                            .accessibilityIdentifier("FailureAPIButton")
                        }
                        
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 50, height: 50)
                            .onTapGesture(perform: viewModel.readEnvironment)
                        
                        Button(action: changeRootView) {
                            Text("Change to Detail View")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(15)
                        }
                        .accessibilityIdentifier("OpenDetailViewButton")
                    }
                }
            }
        }
        .readView(isLoading: $viewModel.isLoading, appError: $viewModel.appError, dismissAlert: viewModel.dismissAlertAction)
        //  MARK: - LifeCycle
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }
}

//  MARK: - Subviews
extension ContentView {}

//  MARK: - Actions
extension ContentView {
    func changeRootView() {
        appEnvironment.changeRootAction(.detail)
    }
}

//  MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
