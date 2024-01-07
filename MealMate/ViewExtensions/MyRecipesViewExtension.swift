//
//  MyRecipesViewExtension.swift
//  MealMate
//
//  Created by Jonas on 16/11/2023.
//

import Foundation
import SwiftUI

extension MyRecipesView {
  func noRecipesView() -> some View {
    VStack {
      Image(systemName: "externaldrive.badge.minus")
        .resizable()
        .frame(maxWidth: 50, maxHeight: 50)
      Text("Ingen oppskrifter")
    }
  }
}
