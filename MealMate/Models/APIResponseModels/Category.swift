//
//  Category.swift
//  MealMate
//
//  Created by Jonas on 22/11/2023.
//

import Foundation

struct Category: Codable, Identifiable, Hashable {
  
  var idCategory: String?
  var strCategory: String?
  var strCategoryThumb: String?
  var strCategoryDescription: String?
  
  var id: String {
    idCategory ?? UUID().uuidString
  }
}
