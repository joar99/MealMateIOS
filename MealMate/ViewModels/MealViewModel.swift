//
//  MealViewModel.swift
//  MealMate
//
//  Created by Jonas on 13/11/2023.
//

import Foundation

@MainActor
final class MealViewModel: ObservableObject {
  
  //Storing these as responsedata as to not use resources parsing them
  @Published var categories: ResponseData? = nil
  @Published var areas: ResponseData? = nil
  @Published var ingredients: ResponseData? = nil
  
  @Published var meals: [Meal]? = nil
  
  private let mealManager: MealDataManager
  init(mealManager: MealDataManager) {
    self.mealManager = mealManager
  }
  
  func setMockMeal() {
    let errorMeal = Meal(strMeal: "Ingen oppskrifter ble funnet med følgende parameter")
    meals.self = [errorMeal]
  }
  
  func fetchMealForCoreData(id: String) async -> Meal? {
    do {
      let responseData = try await mealManager.fetchMeals(endpoint: .idsearch(id))
      let meal = responseData.first
      return meal
    } catch {
      print(error.localizedDescription)
    }
    return nil
  }
  
  func fetchDetailedMeal(id: String) async {
    Task {
      do {
        meals.self = try await mealManager.fetchMeals(endpoint: .idsearch(id))
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func fetchMealName(query: String) async {
    Task {
      do {
        meals.self = try await mealManager.fetchMeals(endpoint: .namesearch(query))
      } catch {
        print(error.localizedDescription)
        setMockMeal()
      }
    }
  }
  
  func fetchMealsIngredient(ingredient: String) async {
    Task {
      do {
        meals.self = try await mealManager.fetchMeals(endpoint: .ingredientsearch(ingredient))
      } catch {
        print(error.localizedDescription)
        setMockMeal()
      }
    }
  }
  
  func fetchMealsCategory(category: String) async {
    Task {
      do {
        meals.self = try await mealManager.fetchMeals(endpoint: .categorysearch(category))
      } catch {
        print(error.localizedDescription)
        setMockMeal()
      }
    }
  }
  
  func fetchMealsArea(area: String) async {
    Task {
      do {
        meals.self = try await mealManager.fetchMeals(endpoint: .areasearch(area))
      } catch {
        print(error.localizedDescription)
        setMockMeal()
      }
    }
  }
  
  func fetchSelections() async {
    do {
      async let categories = mealManager.fetchSelection(endpoint: .categories)
      async let areas = mealManager.fetchSelection(endpoint: .area)
      async let ingredients = mealManager.fetchSelection(endpoint: .ingredients)
      self.categories = try await categories
      self.areas = try await areas
      self.ingredients = try await ingredients
    } catch {
      print(error.localizedDescription)
    }
  }
  
}
