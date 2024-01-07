//
//  TabBarItem.swift
//  MealMate
//
//  Created by Jonas on 16/11/2023.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
  
  case recipes, search, settings
  
  var iconName: String {
    switch self {
    case .recipes: return "book"
    case .search: return "magnifyingglass"
    case .settings: return "gear"
    }
  }
  
  var title: String {
    switch self {
    case .recipes: return "Mine Oppskrifter"
    case .search: return "Søk"
    case .settings: return "Innstillinger"
    }
  }
  
  var color: Color {
    switch self {
    case .recipes: return Color.blue
    case .search: return Color.blue
    case .settings: return Color.blue
    }
  }
  
}
