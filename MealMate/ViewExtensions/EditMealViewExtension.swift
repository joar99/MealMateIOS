//
//  EditMealViewExtension.swift
//  MealMate
//
//  Created by Jonas on 15/11/2023.
//

import Foundation
import SwiftUI
import PhotosUI

extension EditMealView {
  
  func showEditPhoto() -> some View {
    VStack {
      if (photoPicker.selectedImage == nil) {
        let imageData = Data(meal?.image ?? Data())
        let uiImage = UIImage(data: imageData)
        let image = Image(uiImage: uiImage ?? UIImage())
        
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: .infinity, maxHeight: 300)
      } else {
        Image(uiImage: photoPicker.selectedImage ?? UIImage())
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: .infinity, maxHeight: 300)
      }
      
      PhotosPicker(selection: $photoPicker.imageSelection, matching: .images) {
          ZStack {
            RoundedRectangle(cornerRadius: 0)
              .frame(maxWidth: .infinity, maxHeight: 50).foregroundStyle(Color.blue).opacity(0.7).blur(radius: 1).cornerRadius(16)
            Label(
              title: { Text("Velg Bilde").foregroundStyle(Color.black) },
              icon: { Image(systemName: "camera").foregroundStyle(Color.black) }
            )
          }
      }.padding()
    }
  }
  
  func showEditVars() -> some View {
    VStack {
      Divider()
      VStack {
        ThickTextFieldContainer {
          TextField("", text: $titleInput).padding().focused($titleIsFocused)
        }.onTapGesture {
          titleIsFocused = true
        }
      }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
      Divider()
      VStack {
        ThickTextFieldContainer {
          TextField("", text: $categoryInput).padding().focused($categoryIsFocused)
        }.onTapGesture {
          categoryIsFocused = true
        }
      }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
      Divider()
      VStack {
        ThickTextFieldContainer {
          TextField("", text: $areaInput).padding().focused($areaIsFocused)
        }.onTapGesture {
          areaIsFocused = true
        }
      }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
      Divider()
    }
  }
  
  func showEditInstructions() -> some View {
      TextField("Enter text here", text: $instructionsInput, axis: .vertical).padding()
  }
}
