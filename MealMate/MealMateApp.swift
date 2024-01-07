//
//  MealMateApp.swift
//  MealMate
//
//  Created by Jonas on 13/11/2023.
//

import SwiftUI

@main
struct MealMateApp: App {
  
  @AppStorage("isDarkMode") private var isDarkMode = false
  @StateObject var mealEntityModel = MealEntityViewModel()

    var body: some Scene {
      
        WindowGroup {
            ContentView()
            .environmentObject(mealEntityModel)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
