//
//  LoadingView-Modifier.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import SwiftUI

//  MARK: - Modifier
struct CustomViewModifier: ViewModifier {
    @Binding var isLoading: Bool
    @Binding var appError : AppError?
    var dismissAlert: () -> Void
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            LoadingView(isLoading: $isLoading)
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: isLoading)
        .alert(item: $appError) { appAlert in
            Alert(
                title: Text("Title"),
                message: Text(appAlert.errorString),
                dismissButton: .default(Text("Ok"), action: dismissAlert))
        }
    }
}

//  MARK: - Extension View
extension View {
    func readView(isLoading: Binding<Bool>, appError: Binding<AppError?>, dismissAlert: @escaping () -> Void) -> some View {
        modifier(CustomViewModifier(isLoading: isLoading, appError: appError, dismissAlert: dismissAlert))
    }
}
