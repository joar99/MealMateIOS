//
//  MealStorageListViewExtension.swift
//  MealMate
//
//  Created by Jonas on 16/11/2023.
//

import Foundation
import SwiftUI

extension MealStorageListView {
  
  func showMealFavorite() -> some View {
    Group {
      HStack() {
        
        showMealImage()
        
        VStack(alignment: .leading) {
          Text(meal.name ?? "Unknown Name")
            .font(.headline)
            .shadow(radius: 5)
          Divider()
          Image(systemName: "star.fill")
            .resizable()
            .foregroundStyle(Color.yellow)
            .frame(maxWidth: 15, maxHeight: 15)
            .shadow(radius: 5)
            .padding(.leading)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.leading)
    }
  }
  
  func showMealNotFavorite() -> some View {
    Group {
      HStack {
        showMealImage()
        VStack(alignment: .leading) {
          Text(meal.name ?? "Unknown Name")
            .font(.headline)
            .shadow(radius: 5)
          Divider()
          Image(systemName: "star")
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
  
  func showMealImage() -> some View {
    VStack {
      let imageData = Data(meal.image ?? Data())
      let uiImage = UIImage(data: imageData)
      let image = Image(uiImage: uiImage ?? UIImage())
      
      image
        .resizable()
        .aspectRatio(contentMode: .fit)
        .clipShape(Circle())
        .shadow(radius: 10)
        .frame(maxWidth: 65)
    }
  }
  
  func showDeleteButton() -> some View {
    Button(role: .destructive) {
      mealEntityModel.deleteMeal(meal: meal)
    } label: {
      Label("Slett", systemImage: "trash")
    }
    .tint(.red)
  }
  
  func showArchiveButton() -> some View {
    Button {
      mealEntityModel.setArchived(meal: meal)
    } label: {
      Label("Arkiver", systemImage: "archivebox.fill")
    }
    .tint(.blue)
  }
  
  func showUnarchiveButton() -> some View {
    Button {
      mealEntityModel.setArchived(meal: meal)
    } label: {
      Label("Hent fra arkiv", systemImage: "archivebox")
    }
    .tint(.blue)
  }
  
  func showFavoriteButton() -> some View {
    Button {
      mealEntityModel.setFavorite(meal: meal)
    } label: {
      Label("Favoriser", systemImage: "star")
    }
    .tint(.yellow)
  }
  
  func showUnfavoriteButton() -> some View {
    Button {
      mealEntityModel.setFavorite(meal: meal)
    } label: {
      Label("Favoriser", systemImage: "star.slash")
    }
    .tint(.gray)
  }
}
