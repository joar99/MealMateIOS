//
//  SearchRecipesViewExtension.swift
//  MealMate
//
//  Created by Jonas on 14/11/2023.
//

import Foundation
import SwiftUI

extension SearchRecipesView {
  
  func showSearchQueryBtn() -> some View {
    VStack {
      Button(action: {
        showSheet = true
      }, label: {
        ZStack {
          RoundedRectangle(cornerRadius: 16)
            .frame(maxWidth: .infinity, maxHeight: 50).foregroundStyle(Color.blue).opacity(0.7).blur(radius: 1).cornerRadius(16)
          switch currentSelection {
          case .search:
            Label("Søk måltider", systemImage: "magnifyingglass").foregroundStyle(Color.black)
          case .category:
            Label("Søk kategorier", systemImage: "list.clipboard").foregroundStyle(Color.black)
          case .ingridient:
            Label("Søk ingredienser", systemImage: "carrot").foregroundStyle(Color.black)
          case .area:
            Label("Søk område", systemImage: "globe").foregroundStyle(Color.black)
          }
        }
      })
    }
    .sheet(isPresented: $showSheet,onDismiss: {showSheet = false}, content: {
      showSearchModal().presentationDetents([.medium]).presentationDragIndicator(.visible)
    })
  }
  
  func showSearchModal() -> some View {
    VStack {
      HStack {
        Button(action: {
          showSheet = false
        }, label: {
          Text("Avbryt")
        })
        Spacer()
        Image(systemName: currentSelection.rawValue)
        Spacer()
        
        Button(
            action: {
              switch currentSelection {
              case .search: Task{await mealModel.fetchMealName(query: searchQuery)}
              case .category: Task {await mealModel.fetchMealsCategory(category: searchQuery)}
              case .ingridient: Task {await mealModel.fetchMealsIngredient(ingredient: searchQuery)}
              case .area: Task {await mealModel.fetchMealsArea(area: searchQuery)}
              }
              showSheet = false
            }, label: {
                Text("Søk")}
        ).padding(.trailing)
      }.padding()
      switch currentSelection {
      case .search:
        ThickTextFieldContainer {
          TextField("", text: $searchQuery, prompt: Text("Søkeord")).padding()
        }
      case .category: showList(meals: mealModel.categories?.meals, keyPath: \.strCategory)
      case .ingridient: showList(meals: mealModel.ingredients?.meals, keyPath: \.strIngredient)
      case .area: showList(meals: mealModel.areas?.meals, keyPath: \.strArea)
      }
      Spacer()
    }
  }

  func getListItemTint(selection: Meal?, meal: Meal) -> Color {
    switch currentSelection {
    case .area:
      return selection?.strArea == meal.strArea ? .blue : .primary
    case .category:
      return selection?.strCategory == meal.strCategory ? .blue : .primary
    case .ingridient:
      return selection?.strIngredient == meal.strIngredient ? .blue : .primary
    default:
      return .primary
    }
  }
  
  func showList(meals: [Meal]?, keyPath: KeyPath<Meal, String?>) -> some View {
    List {
      ForEach(meals ?? [], id: \.id) { meal in
        Button(action: {
          selectedQuery = meal
          searchQuery = meal[keyPath: keyPath] ?? ""
        }, label: {
          Text(meal[keyPath: keyPath] ?? "")
        }).foregroundStyle(getListItemTint(selection: selectedQuery, meal: meal))
      }
    }
      .listStyle(PlainListStyle())
  }
}
