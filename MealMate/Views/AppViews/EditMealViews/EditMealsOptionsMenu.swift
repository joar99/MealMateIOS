//
//  EditMealsOptionsMenu.swift
//  MealMate
//
//  Created by Jonas on 15/11/2023.
//

import SwiftUI

struct EditMealsOptionsMenu: View {
  
  var meal: MealEntity?
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          NavigationLink(destination: EditMealView(meal: meal, option: .areaCategoryName)) {
            Label("Redigere Område/Kategori/Navn", systemImage: "list.bullet.clipboard").foregroundStyle(Color.blue)
          }
          NavigationLink(destination: EditMealView(meal: meal, option: .instructions)) {
            Label("Redigere instruksjoner", systemImage: "quote.bubble").foregroundStyle(Color.blue)
          }
          NavigationLink(destination: EditMealView(meal: meal, option: .photo)) {
            Label("Redigere bilde", systemImage: "camera").foregroundStyle(Color.blue)
          }
        } header: {
          Text("Rediger")
        }
      }
    }.navigationTitle("Redigeringsalternativer")
  }
}

#Preview {
    EditMealsOptionsMenu()
}
