//
//  MealAPIEndpoints.swift
//  MealMate
//
//  Created by Jonas on 14/11/2023.
//

import Foundation

enum MealAPIEndpoints {
  
  case categories
  case area
  case ingredients
  case categorysearch(String)
  case areasearch(String)
  case ingredientsearch(String)
  case namesearch(String)
  case idsearch(String)
  
  func url(baseUrl: String) -> URL? {
    switch self {
    case .categories:
      return URL(string: "\(baseUrl)list.php?c=list") ?? nil
    case .area:
      return URL(string: "\(baseUrl)list.php?a=list") ?? nil
    case .ingredients:
      return URL(string: "\(baseUrl)list.php?i=list") ?? nil
    case .categorysearch(let category):
      return URL(string: "\(baseUrl)filter.php?c=\(category)")
    case .areasearch(let area):
      return URL(string: "\(baseUrl)filter.php?a=\(area)")
    case .ingredientsearch(let ingredient):
      return URL(string: "\(baseUrl)filter.php?c=\(ingredient)")
    case .namesearch(let query):
      return URL(string: "\(baseUrl)search.php?s=\(query)")
    case .idsearch(let id):
      return URL(string: "\(baseUrl)lookup.php?i=\(id)")
    }
  }
  
}
