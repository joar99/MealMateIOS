//
//  PhotoPickerViewModel.swift
//  MealMate
//
//  Created by Jonas on 15/11/2023.
//

import Foundation
import PhotosUI
import SwiftUI

@MainActor
final class PhotoPickerViewModel: ObservableObject {
  
  @Published private(set) var selectedImage: UIImage? = nil
  @Published var imageSelection: PhotosPickerItem? = nil {
    didSet {
      setImage(from: imageSelection)
    }
  }
  
  private func setImage(from selection: PhotosPickerItem?) {
    guard let selection else {return}
    
    Task {
      do {
        let data = try await selection.loadTransferable(type: Data.self)
        guard let data, let uiImage = UIImage(data: data) else {
          throw URLError(.cannotDecodeContentData)
        }
        selectedImage = uiImage
      } catch {
        print(error)
      }
    }
  }
}
