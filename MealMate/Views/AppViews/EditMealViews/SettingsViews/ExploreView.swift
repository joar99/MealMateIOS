//
//  ExploreAreas.swift
//  MealMate
//
//  Created by Jonas on 16/11/2023.
//

import SwiftUI

struct ExploreView: View {
  
  let areaCodes: [String: String] = [ "American": "US", "British": "GB", "Canadian": "CA", "Chinese": "CN", "Croatian": "HR", "Dutch": "NL", "Egyptian": "EG", "Filipino": "PH", "French": "FR", "Greek": "GR", "Indian": "IN", "Irish": "IE", "Italian": "IT", "Jamaican": "JM", "Japanese": "JP", "Kenyan": "KE", "Malaysian": "MY", "Mexican": "MX", "Moroccan": "MA", "Polish": "PL", "Portuguese": "PT", "Russian": "RU", "Spanish": "ES", "Thai": "TH", "Tunisian": "TN", "Turkish": "TR", "Unknown": "UN", "Vietnamese": "VN" ]
  
  var settingsModel: SettingsViewModel
  var selection: SearchSelection
  
  var body: some View {
    
    NavigationStack {
      switch selection {
      case .search:
        EmptyView()
      case .category:
        List {ForEach(settingsModel.categories ?? []) { category in
          NavigationLink(destination: CategoryView(category: category)) {
            HStack {
              if let strCategoryThumb = category.strCategoryThumb {
                AsyncImage(url: URL(string: strCategoryThumb)) { image in
                  image
                    .resizable()
                } placeholder: {
                  Image("knifeplaceholder")
                    .resizable()
                }
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .shadow(radius: 5)
                .frame(maxWidth: 65)
              }
              Text(category.strCategory ?? "")
            }
          }
        }
        }
      case .ingridient:
        List {ForEach(settingsModel.ingredients?.meals ?? []) {meal in Text(meal.strIngredient ?? "")}}
      case .area:
        List {
          ForEach(settingsModel.areas?.meals ?? []) { meal in
            if let area = meal.strArea, let code = areaCodes[area] {
              HStack {
                Text(meal.strArea ?? "")
                Spacer()
                AsyncImage(url: URL(string: "https://flagsapi.com/\(code)/flat/16.png")) { image in
                  image
                    .resizable()
                } placeholder: {
                  Image("flagplaceholder")
                    .resizable()
                }
                .frame(maxWidth: 16, maxHeight: 16)
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 5)
              }
            }
          }
        }
      }
    }.navigationTitle("Utforsk")
  }
}


