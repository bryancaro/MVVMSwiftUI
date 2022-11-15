//
//  AppView.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 9/9/22.
//

import SwiftUI

struct AppView: View {
    //  MARK: - Environment
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
            Group {
                switch viewModel.appActive {
                case .loading:
                    ZStack {
                        Color.red.edgesIgnoringSafeArea(.all)
                            
                        Text("Tap me...")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        viewModel.changeRootAction(.home)
                    }
                case .home:
                    ContentView()
                case .detail:
                    DetailView()
                }
            }
        }
        .environmentObject(viewModel)
        //  MARK: - LifeCycle
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }
}

//  MARK: - Subviews
extension AppView {}

//  MARK: - Actions
extension AppView {
    func firstAction() {
        
    }
}

//  MARK: - Preview
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
