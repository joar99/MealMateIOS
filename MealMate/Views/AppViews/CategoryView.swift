//
//  CategoryView.swift
//  MealMate
//
//  Created by Jonas on 22/11/2023.
//

import SwiftUI

struct CategoryView: View {
  
  let category: Category
  
  var body: some View {
    VStack {
      AsyncImage(url: URL(string: category.strCategoryThumb ?? "foodplaceholder")) { image in
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
        Text(category.strCategory ?? "Ukjent tittel").font(.title2).bold().shadow(radius: 2)
      }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
      
      LazyVStack {
        ScrollView {
          Text(category.strCategoryDescription ?? "Ingen gitte instruksjoner for å forberede dette måltidet")
        }.frame(maxHeight: 200)
      }.frame(maxWidth: .infinity, maxHeight: 200,alignment: .leading).padding()
    }
    
    Spacer()
  }
}


/*#Preview {
  CategoryView()
}*/
