//
//  MyRecipesViewModel.swift
//  MealMate
//
//  Created by Jonas on 14/11/2023.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
final class MealEntityViewModel: ObservableObject {
  
  let container: NSPersistentContainer
  @Published var savedEntities: [MealEntity] = []
  @Published var selectedEntity: MealEntity? = nil
  
  init() {
    container = NSPersistentContainer(name: "MealsContainer")
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Error loading CoreData: \(error)")
      }
    }
    fetchMeals()
  }
  
  func fetchMeals() {
    let request = NSFetchRequest<MealEntity>(entityName: "MealEntity")
    do {
      savedEntities = try container.viewContext.fetch(request)
      sortSavedEntitiesByFavorite()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func sortSavedEntitiesByFavorite() { savedEntities = savedEntities.sorted { $0.isFavorite && !$1.isFavorite } }
  
  func fetchMealById(id: String) -> MealEntity? {
    let context = container.viewContext
    let request = NSFetchRequest<MealEntity>(entityName: "MealEntity")
    request.predicate = NSPredicate(format: "id == %@", id)
    do {
      let results = try context.fetch(request)
      if let meal = results.first {
        return meal
      } else {
        return nil
      }
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
  
  
  func downloadImageData(from url: String) async -> Data? {
    let imageURL = URL(string: url)!
    do {
      let (data, _) = try await URLSession.shared.data(from: imageURL)
      let imageData = UIImage(data: data)?.pngData()
      return imageData
    } catch {
      print("Error downloading image data: \(error)")
      return nil
    }
  }
  
  func addMeal(id: String, name: String, category: String, area: String, instructions: String, image: String) async {
    let newMeal = MealEntity(context: container.viewContext)
    newMeal.id = id
    newMeal.name = name
    newMeal.category = category
    newMeal.area = area
    newMeal.instructions = instructions
    newMeal.isFavorite = false
    newMeal.isArchived = false
    let imageData = await downloadImageData(from: image)
    newMeal.image = imageData
    saveData()
    fetchMeals()
  }
  
  func updateNameAreaCategory(id: String, name: String, area: String, category: String) {
    if let mealToUpdate = fetchMealById(id: id) {
      mealToUpdate.name = name
      mealToUpdate.area = area
      mealToUpdate.category = category
      saveData()
    }
  }
  
  func updateInstructions(id: String, instructions: String) {
    if let mealToUpdate = fetchMealById(id: id) {
      mealToUpdate.instructions = instructions
      saveData()
    }
  }
  
  func updateImage(mealId: String, image: UIImage) {
    if let mealToUpdate = fetchMealById(id: mealId) {
      if let imageData = image.pngData() {
        mealToUpdate.image = imageData
        saveData()
      }
    }
  }
  
  func deleteMeal(meal: MealEntity) {
    container.viewContext.delete(meal)
    saveData()
  }
  
  func setFavorite(meal: MealEntity) {
    container.viewContext.perform {
      meal.isFavorite.toggle()
      do {
        try self.container.viewContext.save()
      } catch {
        print(error.localizedDescription)
      }
      self.saveData()
    }
    saveData()
  }
  
  func setArchived(meal: MealEntity) {
    container.viewContext.perform {
      meal.isArchived.toggle()
      do {
        try self.container.viewContext.save()
      } catch {
        print(error.localizedDescription)
      }
      self.saveData()
    }
    saveData()
  }

  func saveData() {
    do {
      try container.viewContext.save()
      print("Data Successfully Saved")
      fetchMeals()
    } catch {
      print("Error Saving Data: \(error)")
    }
  }
  
}
