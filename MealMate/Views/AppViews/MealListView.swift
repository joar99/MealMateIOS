//
//  MealListView.swift
//  MealMate
//
//  Created by Jonas on 14/11/2023.
//

import SwiftUI

struct MealListView: View {
  
  var meal: Meal
  var imageName: String
  
  var body: some View {
    
    HStack {
      AsyncImage(url: URL(string: meal.strMealThumb ?? "knifeplaceholder")) { image in
        image
          .resizable()
      } placeholder: {
        Image("knifeplaceholder")
          .resizable()
      }
      .aspectRatio(contentMode: .fit)
      .clipShape(Circle())
      .shadow(radius: 5)
      .frame(maxWidth: 65)
      
      VStack(alignment: .leading) {
        Text(meal.strMeal ?? "Unknown Name")
          .font(.headline)
          .shadow(radius: 5)
        Divider()
        Image(systemName: imageName)
          .resizable()
          .foregroundStyle(Color.gray)
          .frame(maxWidth: 15, maxHeight: 15)
          .shadow(radius: 5)
          .padding(.leading)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.leading)
  }
  
}

#Preview {
  HStack {
    Image("foodplaceholder")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .clipShape(Circle())
      .shadow(radius: 10)
      .frame(maxWidth: 65)
    
    VStack(alignment: .leading) {
      Text("Unknown Name")
        .font(.headline)
        .shadow(radius: 5)
      Divider()
      Image(systemName: "folder")
        .resizable()
        .foregroundStyle(Color.gray)
        .frame(maxWidth: 15, maxHeight: 15)
        .shadow(radius: 5)
        .padding(.leading)
    }
  }
  .frame(maxWidth: .infinity, alignment: .leading)
  .padding(.leading)
}
