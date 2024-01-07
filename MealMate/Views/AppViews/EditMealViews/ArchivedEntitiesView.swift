//
//  ArchivedEntitiesView.swift
//  MealMate
//
//  Created by Jonas on 16/11/2023.
//

import SwiftUI

struct ArchivedEntitiesView: View {
  
  @State var recipesIsEmpty: Bool = true
  @EnvironmentObject var mealEntityModel: MealEntityViewModel
  
  var body: some View {
    
    VStack {
      if mealEntityModel.savedEntities.isEmpty {
        noArchivedRecipes()
      } else {
        List {
          ForEach(mealEntityModel.savedEntities.filter {$0.isArchived}) { meal in
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
        mealEntityModel.fetchMeals
      }
    }
  }
}

extension ArchivedEntitiesView {
  func noArchivedRecipes() -> some View {
    VStack {
      Image(systemName: "externaldrive.badge.minus")
        .resizable()
        .frame(maxWidth: 50, maxHeight: 50)
      Text("Ingen arkiverte oppskrifter")
    }
  }
}
