//
//  SearchRecipesView.swift
//  MealMate
//
//  Created by Jonas on 13/11/2023.
//

import SwiftUI

struct SearchRecipesView: View {
  
  @StateObject var mealModel: MealViewModel = MealViewModel(mealManager: MealDataManager())
  @EnvironmentObject var mealEntityModel: MealEntityViewModel
  
  @State var searchQuery: String = ""
  @State var showSheet: Bool = false
  
  @State private(set) var currentSelection: SearchSelection = .category
  @State var selectedQuery: Meal?
  
  func checkIfMealExists(meal: Meal, savedEntities: [MealEntity]) -> Bool {
    return savedEntities.contains { entity in
      entity.id == meal.idMeal
    }
  }
  
  var body: some View {
    
    VStack {
      Picker("Selection", selection: $currentSelection) {
        ForEach(SearchSelection.allCases, id: \.self) { selection in
          Image(systemName: selection.rawValue)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
      .padding()
      Divider()
      
      if mealModel.meals?.first != nil {
          List {
            ForEach(mealModel.meals ?? [], id: \.self) { meal in
              let alreadyFavorite: Bool = checkIfMealExists(meal: meal, savedEntities: mealEntityModel.savedEntities)
              if !alreadyFavorite {
                NavigationLink(destination: MealView(id: meal.idMeal ?? "")) {
                  MealListView(meal: meal, imageName: "folder")
                    .swipeActions(edge: .leading) {
                      Button {
                        Task {
                          let newMeal: Meal? = await mealModel.fetchMealForCoreData(id: meal.id) ?? nil
                          if let meal = newMeal {
                            if let mealId = meal.idMeal {
                              Task {
                                await mealEntityModel.addMeal(id: mealId, name: meal.strMeal ?? "Default Name",
                                category: meal.strCategory ?? "Default Category", area: meal.strArea ?? "Default Area", instructions: meal.strInstructions ?? "No Instructions Given", image: meal.strMealThumb ?? "No Image")
                              }
                            }
                          }
                        }
                      } label: {
                        Label("Lagre", systemImage: "folder")
                      }
                      .tint(.blue)
                    }
                }
                
              } else {
                NavigationLink(destination: MealView(id: meal.idMeal ?? "")) {
                  MealListView(meal: meal, imageName: "folder.fill")
                }
              }
            }
          }
        } else {
          Text("Bruk søkeknappen på bunnen for å søke etter måltider").frame(alignment: .center).font(.headline).shadow(radius: 1).padding()
      }
      Spacer()
      Divider()
      showSearchQueryBtn().padding(.bottom)
    }.onAppear {
      Task {
        await mealModel.fetchSelections()
      }
      
    }
  }
}

#Preview {
  SearchRecipesView()
}
