//
//  MyRecipesView.swift
//  MealMate
//
//  Created by Jonas on 13/11/2023.
//

import SwiftUI

struct MyRecipesView: View {
  
  @State var recipesIsEmpty: Bool = true
  @EnvironmentObject var mealEntityModel: MealEntityViewModel
  
  var body: some View {
    
    VStack {
      if mealEntityModel.savedEntities.filter({!$0.isArchived}).isEmpty {
        noRecipesView()
      } else {
        List {
          ForEach(mealEntityModel.savedEntities.filter {!$0.isArchived}) { meal in
            if !meal.isFavorite {
              MealStorageListView(meal: meal)
            } else {
              MealStorageListView(meal: meal)
            }
            
          }
        }
      }
    }.onAppear {
      Task {
        mealEntityModel.fetchMeals()
      }
    }
  }
}


