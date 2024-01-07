//
//  SettingsViewModel.swift
//  MealMate
//
//  Created by Jonas on 16/11/2023.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
  
  @Published var areas: ResponseData? = nil
  @Published var ingredients: ResponseData? = nil
  @Published var categories: [Category]? = nil
  
  private let mealManager: MealDataManager
  init(mealManager: MealDataManager) {
    self.mealManager = mealManager
  }
  
  func fetchSelections() async {
    do {
      async let areas = mealManager.fetchSelection(endpoint: .area)
      async let ingredients = mealManager.fetchSelection(endpoint: .ingredients)
      async let categories = mealManager.fetchCategories()
      self.areas = try await areas
      self.ingredients = try await ingredients
      self.categories = try await categories
    } catch {
      print(error.localizedDescription)
    }
  }
  
}
