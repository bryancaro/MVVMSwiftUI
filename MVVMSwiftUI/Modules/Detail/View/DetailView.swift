//
//  DetailView.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import SwiftUI

struct DetailView: View {
    //  MARK: - Environment
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //  MARK: - Observed Object
    @ObservedObject var viewModel: ContentView.ViewModel
    //  MARK: - Binding variables
    //  MARK: - State variables
    //  MARK: - Constant variables
    //  MARK: - Properties
    //  MARK: - Initializer View
    init(viewModel: ContentView.ViewModel) {
        print("[DEBUG]-[VIEW] [DetailView]: [init]")
        self.viewModel = viewModel
    }
    //  MARK: - Principal View
    var body: some View {
        ZStack {
            VStack {
                Button(action: dismissView) {
                    Text("Return to previews View")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            }
        }
        //  MARK: - LifeCycle
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
}

//  MARK: - Subviews
extension DetailView {
    
}

//  MARK: - Actions
extension DetailView {
    func onAppear() {
        print("[DEBUG]-[VIEW] [DetailView]: [onAppear]")
    }
    
    func onDisappear() {
        print("[DEBUG]-[VIEW] [DetailView]: [onDisappear]")
    }
    
    func dismissView() {
        viewModel.closeDetailAction()
        //presentationMode.wrappedValue.dismiss()
    }
}

//  MARK: - Preview
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: ContentView.ViewModel())
    }
}
