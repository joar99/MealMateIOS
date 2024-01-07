//
//  MealEntityView.swift
//  MealMate
//
//  Created by Jonas on 15/11/2023.
//

import SwiftUI

struct MealEntityView: View {
  
  @EnvironmentObject var mealEntityModel: MealEntityViewModel
  var meal: MealEntity?
  
  var body: some View {
    NavigationStack {
      VStack {
        
        
        let imageData = Data(meal?.image ?? Data())
          let uiImage = UIImage(data: imageData)
          let image = Image(uiImage: uiImage ?? UIImage())
          
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: 300)
        
        VStack {
          Text(mealEntityModel.selectedEntity?.name ?? "Ukjent tittel").font(.title2).bold().shadow(radius: 2)
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
        
        VStack {
          Text(mealEntityModel.selectedEntity?.category ?? "Ukjent kategori").font(.callout)
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
        
        VStack {
          Text(mealEntityModel.selectedEntity?.area ?? "Ukjent opprinnelse").font(.callout)
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
        
        LazyVStack {
          ScrollView {
            Text(mealEntityModel.selectedEntity?.instructions ?? "Ingen gitte instruksjoner for å forberede dette måltidet")
          }.frame(maxHeight: 200)
        }.frame(maxWidth: .infinity, maxHeight: 200,alignment: .leading).padding()
      }.onAppear {
        mealEntityModel.selectedEntity = meal ?? MealEntity()
      }
      
      Spacer()
      NavigationLink(destination: EditMealsOptionsMenu(meal: meal)) {
        ZStack {
          RoundedRectangle(cornerRadius: 0)
            .frame(maxWidth: .infinity, maxHeight: 50).foregroundStyle(Color.blue).opacity(0.7).blur(radius: 1).cornerRadius(16)
          Label(
            title: { Text("Rediger Måltid").foregroundStyle(Color.black) },
            icon: { Image(systemName: "paperclip").foregroundStyle(Color.black) }
          )
        }.padding()
      }
    }.navigationTitle("Oppskrift")
  }
}
