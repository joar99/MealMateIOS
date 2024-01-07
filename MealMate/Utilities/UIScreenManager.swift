//
//  UIScreenManager.swift
//  MealMate
//
//  Created by Jonas on 13/11/2023.
//

import Foundation
import SwiftUI

extension UIScreen { static var current: UIScreen? { UIWindow.current?.screen } }

extension UIWindow { static var current: UIWindow? { for scene in UIApplication.shared.connectedScenes { guard let windowScene = scene as? UIWindowScene else { continue }; for window in windowScene.windows { if window.isKeyWindow { return window } } }; return nil } }
