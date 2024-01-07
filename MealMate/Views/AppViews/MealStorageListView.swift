//
//  MealStorageListView.swift
//  MealMate
//
//  Created by Jonas on 15/11/2023.
//

import SwiftUI

struct MealStorageListView: View {
  
  @EnvironmentObject var mealEntityModel: MealEntityViewModel
  var meal: MealEntity
  
  var body: some View {
    
    if meal.isFavorite == false {
      NavigationStack {
        NavigationLink(destination: MealEntityView(meal: meal)) {
          showMealNotFavorite()
          .swipeActions(edge: .leading) {
            switch meal.isArchived {
            case false:
              showFavoriteButton()
            case true:
              showUnarchiveButton()
            }
          }
          .swipeActions(edge: .trailing) {
            switch meal.isArchived {
            case false:
              showArchiveButton()
              .tint(.blue)
            case true:
              showDeleteButton()
            }
          }
        }
      }
    } else {
      NavigationStack {
        NavigationLink(destination: MealEntityView(meal: meal)) {
          showMealFavorite()
          .swipeActions(edge: .leading) {
            switch meal.isArchived {
            case false:
              showUnfavoriteButton()
            case true:
              showUnarchiveButton()
            }
          }
          .swipeActions(edge: .trailing) {
            switch meal.isArchived {
            case false:
              EmptyView()
              //showArchiveButton()
            case true:
              showDeleteButton()
            }
          }
        }
      }
    }
  }
}
