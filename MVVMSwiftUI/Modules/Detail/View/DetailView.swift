//
//  DetailView.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import SwiftUI

struct DetailView: View {
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
            VStack {
                Button(action: changeRootView) {
                    Text("Change to Loading View")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
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
extension DetailView {}

//  MARK: - Actions
extension DetailView {
    func changeRootView() {
        appEnvironment.changeRootAction(.loading)
    }
}

//  MARK: - Preview
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
