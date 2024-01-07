//
//  SettingsView.swift
//  MealMate
//
//  Created by Jonas on 13/11/2023.
//

import SwiftUI

struct SettingsView: View {
  
  @AppStorage("isDarkMode") private var isDarkMode = false
  
  @StateObject var settingsModel: SettingsViewModel = SettingsViewModel(mealManager: MealDataManager())
  @State private(set) var currentSelection: SearchSelection = .area
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          NavigationLink(destination: ExploreView(settingsModel: settingsModel, selection: currentSelection).onAppear{currentSelection = .area}) {
            Label("Utforsk landområder", systemImage: "globe")
          }
          NavigationLink(destination: ExploreView(settingsModel: settingsModel, selection: currentSelection).onAppear{currentSelection = .ingridient}) {
            Label("Utforsk ingredienser", systemImage: "carrot.fill")
          }
          NavigationLink(destination: ExploreView(settingsModel: settingsModel, selection: currentSelection).onAppear{currentSelection = .category}) {
            Label("Utforsk kategorier", systemImage: "quote.bubble")
          }
        } header: {
          Text("Rediger")
        }
        
        Section {
          Toggle(isOn: $isDarkMode,
                 label: {
            Label(
              title: { Text("Aktiver mørk modus") },
              icon: { Image(systemName: "moon.circle") }
            )
          })
        } header: {
          Text("Skjerm")
        }
        Section {
          NavigationLink(destination: ArchivedEntitiesView()) {
            Label("Redigere arkiv", systemImage: "archivebox.fill")
          }
        } header: {
          Text("Arkiv")
        }
      }.onAppear {
        Task {
          await settingsModel.fetchSelections()
        }
      }
    }.navigationTitle("Instillinger")
  }
}

#Preview {
    SettingsView()
}
