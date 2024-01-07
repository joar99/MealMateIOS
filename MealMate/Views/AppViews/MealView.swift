//
//  MealView.swift
//  MealMate
//
//  Created by Jonas on 14/11/2023.
//

import SwiftUI

struct MealView: View {
  
  let id: String
  @StateObject var mealModel: MealViewModel = MealViewModel(mealManager: MealDataManager())
  
  var body: some View {
    VStack {
      if let meal = mealModel.meals?.first {
        AsyncImage(url: URL(string: meal.strMealThumb ?? "foodplaceholder")) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: 300)
        } placeholder: {
          Image("foodplaceholder")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: 300)
        }
        
        VStack {
          Text(meal.strMeal ?? "Ukjent tittel").font(.title2).bold().shadow(radius: 2)
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
        
        VStack {
          Text(meal.strCategory ?? "Ukjent kategori").font(.callout)
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
        
        VStack {
          Text(meal.strArea ?? "Ukjent opprinnelse").font(.callout)
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
        
        LazyVStack {
          ScrollView {
            Text(meal.strInstructions ?? "Ingen gitte instruksjoner for å forberede dette måltidet")
          }.frame(maxHeight: 200)
        }.frame(maxWidth: .infinity, maxHeight: 200,alignment: .leading).padding()
      } else {
        Text("En feil har oppstått, vi fant dessverre ikke dette måltidet i databasen")
      }
      
      Spacer()
    }.onAppear {
      Task {
        await mealModel.fetchDetailedMeal(id: id)
      }
    }
  }
}

#Preview {
    MealView(id: "")
}
