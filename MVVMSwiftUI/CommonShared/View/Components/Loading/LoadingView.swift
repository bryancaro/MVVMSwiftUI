//
//  LoadingView.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import SwiftUI

struct LoadingView: View {
    //  MARK: - Environment
    //  MARK: - Observed Object
    //  MARK: - Binding variables
    @Binding var isLoading: Bool
    //  MARK: - State variables
    //  MARK: - Constant variables
    var title: String = "Loading"
    //  MARK: - Properties
    //  MARK: - Initializer View
    //  MARK: - Principal View
    var body: some View {
        ZStack {
            if isLoading {
                ZStack {
                    Background
                    
                    VStack {
                        Text(title)
                            .font(.body.weight(.bold))
                            .foregroundColor(.white)
                    }
                    
                }
                .edgesIgnoringSafeArea(.all)
                .transition(.move(edge: .top))
            }
        }
        //  MARK: - LifeCycle
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
}

//  MARK: - Subviews
extension LoadingView {
    var Background: some View {
        Color.black.opacity(0.8)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//  MARK: - Actions
extension LoadingView {
    func onAppear() {
        print("[DEBUG]-[VIEW] [LoadingView]: [onAppear]")
    }
    
    func onDisappear() {
        print("[DEBUG]-[VIEW] [LoadingView]: [onDisappear]")
    }
}

//  MARK: - Preview
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(true))
    }
}
