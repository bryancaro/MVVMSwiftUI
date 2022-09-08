//
//  TimeInterval-Extensions.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import Foundation

extension TimeInterval {
    var milliseconds: Int {
        return Int(self * 1_000)
    }
}
