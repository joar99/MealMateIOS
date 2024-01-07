//
//  IntroAnimationView.swift
//  MealMate
//
//  Created by Jonas on 16/11/2023.
//

import SwiftUI

struct IntroAnimationView: View {
  
  @State private var offset = CGSize(width: 200, height: -200)
  
  var linePoints: (CGPoint, CGPoint) {
      let initialPoint = CGPoint(x: 400, y: 100)
      let finalPoint = CGPoint(x: 0, y: 500)
      return (initialPoint, finalPoint)
  }
  
  var body: some View {
    
    ZStack {
      RoundedRectangle(cornerRadius: 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().backgroundStyle(Color.black).foregroundStyle(Color.black)
      
      Path() { path in
            path.move(to: linePoints.0)
            path.addLine(to: linePoints.1)
        }
        .stroke(Color.white, lineWidth: 3)
      
      Image("ratoncheese")
        .offset(offset)
        .animation(.linear(duration: 2).delay(1), value: offset)
        .padding(20)
        .onAppear {
          offset = CGSize(width: -200, height: 200)
        }
      
      Image("ratcrash")
        .position(x: 70, y: 500)
          .opacity(offset == CGSize(width: -200, height: 200) ? 1 : 0)
          .animation(.easeInOut(duration: 0.5).delay(2), value: offset)
          .scaleEffect(offset == CGSize(width: -200, height: 200) ? 1.5 : 1)
          .animation(.easeInOut(duration: 0.5).delay(2.5).repeatCount(1, autoreverses: true), value: offset)
        
    }
  }
}

#Preview {
    IntroAnimationView()
}

