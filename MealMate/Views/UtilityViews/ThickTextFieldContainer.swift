//
//  ThickTextFieldContainer.swift
//  MealMate
//
//  Created by Jonas on 13/11/2023.
//

import SwiftUI

struct ThickTextFieldContainer<Content: View>: View {
  
  let content: Content
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 16)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.80, maxHeight: UIScreen.main.bounds.height * 0.08)
        .foregroundStyle(Color.textfieldcontainer)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 20)
      
      //SHOULD BE ABLE TO PLACE A TEXTFIELD HERE
      content
        .padding()
    }
    .frame(maxWidth: UIScreen.main.bounds.width * 0.80, maxHeight: UIScreen.main.bounds.height * 0.08)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
}


