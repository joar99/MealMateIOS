//
//  ContentView.swift
//  MealMate
//
//  Created by Jonas on 13/11/2023.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject var mealEntityModel: MealEntityViewModel
  
  @State var animationRunning: Bool = true
  
  @State var tabSelection: TabBarItem = .recipes
  
  var body: some View {
    
    NavigationStack {
      CustomTabBarContainerView(selection: $tabSelection) {
        MyRecipesView().navigationTitle(tabSelection.title)
          .tabBarItem(tab: .recipes, selection: $tabSelection)
        
        SearchRecipesView().navigationTitle(tabSelection.title)
          .tabBarItem(tab: .search, selection: $tabSelection)
        
        SettingsView().navigationTitle(tabSelection.title)
          .tabBarItem(tab: .settings, selection: $tabSelection)
      }.navigationTitle(tabSelection.title)
      
    }
    .fullScreenCover(isPresented: $animationRunning) {
      IntroAnimationView()
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            animationRunning = false
          }
        }
    }
  }
}


//REPLACE CUSTOM TAB BAR WITH THIS TO TEST APP WITH NATIVE IOS TABBAR VIEW
//@State var selectedTab: Tabs = .oppskrifter
/*TabView(selection: $selectedTab) {
  
  MyRecipesView()
    .tabItem {
      Label("Mine oppskrifter", systemImage: "book")
    }.tag(Tabs.oppskrifter)
  
  SearchRecipesView()
    .tabItem {
      Label("Søk", systemImage: "magnifyingglass")
    }.tag(Tabs.søk)
  
  SettingsView()
    .tabItem {
      Label("Innstillinger", systemImage: "gear")
    }.tag(Tabs.innstillinger)
}
.navigationTitle(selectedTab.rawValue.capitalized)*/
/*import Foundation
import SwiftUI

enum Tabs: String {
  case oppskrifter
  case søk
  case innstillinger
}*/
