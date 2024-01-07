//
//  MealDataManager.swift
//  MealMate
//
//  Created by Jonas on 13/11/2023.
//

import Foundation

actor MealDataManager: MealDataManagerProtocol {
  
  private(set) var BaseUrl: String = "https://www.themealdb.com/api/json/v1/1/"
  
  func fetchSelection(endpoint: MealAPIEndpoints) async throws -> ResponseData {
    guard let url = endpoint.url(baseUrl: BaseUrl) else {
      throw URLError(.badURL)
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
    return responseData
  }
  
  func fetchMeals(endpoint: MealAPIEndpoints) async throws -> [Meal] {
    guard let url = endpoint.url(baseUrl: BaseUrl) else {
      throw URLError(.badURL)
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
    let meals = responseData.meals.map { $0 }
    return meals
  }
  
  func fetchCategories() async throws -> [Category] {
    guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
      throw URLError(.badURL)
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    let responseData = try JSONDecoder().decode(CategoryResponseData.self, from: data)
    let categories = responseData.categories.map { $0 }
    return categories
  }
  
}
