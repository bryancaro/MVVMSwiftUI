//
//  UIImpactFeedBack.swift
//  MVVMSwiftUI
//
//  Created by Bryan Caro on 3/9/22.
//

import UIKit

func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}
