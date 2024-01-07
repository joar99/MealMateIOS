//
//  MealStorageView.swift
//  MealMate
//
//  Created by Jonas on 15/11/2023.
//

import SwiftUI
import PhotosUI


struct EditMealView: View {
  
  var meal: MealEntity?
  var option: EditMealOption
  
  @EnvironmentObject var mealEntityModel: MealEntityViewModel
  @StateObject var photoPicker: PhotoPickerViewModel = PhotoPickerViewModel()
  
  @State var titleInput: String = "Title"
  @State var categoryInput: String = "Category"
  @State var areaInput: String = "Area"
  @State var instructionsInput: String = "Lorem ipsum dolor sit amet"
  
  @State var showAlert: Bool = false
  
  //@FOCUSSTATE
  @FocusState var titleIsFocused: Bool
  @FocusState var categoryIsFocused: Bool
  @FocusState var areaIsFocused: Bool
  
  var body: some View {
    VStack {
      
      switch option {
      case.areaCategoryName:
        showEditVars()
      case .instructions:
        showEditInstructions()
      case .photo:
        showEditPhoto()
      }
      
      Spacer()
      HStack {
        Button(action: {
          switch option {
          case .areaCategoryName:
            if let mealId = meal?.id {
              mealEntityModel.updateNameAreaCategory(id: mealId, name: titleInput, area: areaInput, category: categoryInput)
              mealEntityModel.selectedEntity?.name = titleInput
              mealEntityModel.selectedEntity?.area = areaInput
              mealEntityModel.selectedEntity?.category = categoryInput
              showAlert = true
            }
          case .instructions:
            if let mealId = meal?.id {
              mealEntityModel.updateInstructions(id: mealId, instructions: instructionsInput)
              mealEntityModel.selectedEntity?.instructions = instructionsInput
              showAlert = true
            }
          case .photo:
            if let mealId = meal?.id {
              if let image = photoPicker.selectedImage {
                mealEntityModel.updateImage(mealId: mealId, image: image)
                if let imageNew = image.pngData() {
                  mealEntityModel.selectedEntity?.image = imageNew
                }
                showAlert = true
              }
              print("Photo Is Nil")
            }
          }
        }, label: {
          ZStack {
            RoundedRectangle(cornerRadius: 0)
              .frame(maxWidth: .infinity, maxHeight: 50).foregroundStyle(Color.blue).opacity(0.7).blur(radius: 1).cornerRadius(16)
            Label(
              title: { Text("Lagre Endringer").foregroundStyle(Color.black) },
              icon: { Image(systemName: "square.and.arrow.down.on.square.fill").foregroundStyle(Color.black) }
            )
          }.padding()
        })
      }.alert(isPresented: $showAlert) {
        Alert(
          title: Text("Endringer Lagret"),
          message: Text("Endringer er blitt lagret i databasen"),
          dismissButton: .default(Text("OK"))
        )
      }
    }.onAppear {
      titleInput = meal?.name ?? "Ingen Navn"
      categoryInput = meal?.category ?? "Ingen Kategori"
      areaInput = meal?.area ?? "Ingen Område"
      instructionsInput = meal?.instructions ?? "Ingen Instruksjoner"
    }
  }
}

/*#Preview {
  EditMealView(option: .instructions)
}*/


