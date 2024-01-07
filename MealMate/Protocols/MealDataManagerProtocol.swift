//
//  MealDataManagerProtocol.swift
//  MealMate
//
//  Created by Jonas on 13/11/2023.
//

import Foundation

protocol MealDataManagerProtocol {
  func fetchSelection(endpoint: MealAPIEndpoints) async throws -> ResponseData
  func fetchMeals(endpoint: MealAPIEndpoints) async throws -> [Meal]
}
