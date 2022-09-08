//
//  String-Extension.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 8/9/22.
//

import Foundation

extension String {
    var localized: String {
        var localizedString = NSLocalizedString(self, comment:"")
        localizedString = localizedString.replacingOccurrences(of: "%s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%1$s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%2$s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%3$s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%4$s", with: "%@")
        return localizedString
    }
}
