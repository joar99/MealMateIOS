//
//  ResponseData.swift
//  MealMate
//
//  Created by Jonas on 14/11/2023.
//

import Foundation

struct ResponseData : Decodable {
  var meals: [Meal]
}
