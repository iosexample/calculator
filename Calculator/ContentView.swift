//
//  ContentView.swift
//  Calculator
//
//  Created by Dong on 25/2/2020.
//  Copyright © 2020 DONG. All rights reserved.
//

import SwiftUI

struct CalculatorButtonRow: View {
//  @Binding var brain: CalculatorBrain
  var model: CalculatorModel
  
  let row: [CalculatorButtonItem]
  var body: some View {
    HStack {
      ForEach(row, id:\.self) { item in
        CalculatorButton(
          title: item.title,
          size: item.size,
          foregroundColor: item.foregroundColor,
          backgroundColorName: item.backgroundColorName) {
            self.model.apply(item)
        }
      }
    }
  }
}

struct ContentView: View {
  
//  @State private var brain: CalculatorBrain = .left("0")
  @ObservedObject var model = CalculatorModel()
  
  var body: some View {
    VStack(spacing: 12) {
      Spacer()
      Button("操作履历：\(model.history.count)") {
        print(self.model.historyDetail)
      }
      Text(model.brain.output)
        .font(.system(size:76))
        .minimumScaleFactor(0.5)
        .padding(.trailing, 24)
        .lineLimit(1)
        .frame(
          minWidth:0,
          maxWidth: .infinity,
          alignment: .trailing
        )
      CalculatorButtonPad(model: model)
        .padding(.bottom)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        ContentView().colorScheme(.light)
//        ContentView().previewDevice("iPhone SE").scaleEffect(UIScreen.main.bounds.width/414)
      }
    }
}

struct CalculatorButton: View {
  let fontSize: CGFloat = 38
  let title: String
  let size: CGSize
  let foregroundColor: Color
  let backgroundColorName: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.system(size:fontSize))
        .foregroundColor(foregroundColor)
        .frame(width:size.width, height:size.height)
        .background(Color(backgroundColorName))
        .cornerRadius(size.width / 2)
    }
  }
}

struct CalculatorButtonPad: View {
//  @Binding var brain: CalculatorBrain
  var model: CalculatorModel
  
  
  let pad:[[CalculatorButtonItem]] = [
    [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
    [.digit(7), .digit(8), .digit(9), .op(.multiply)],
    [.digit(4), .digit(5), .digit(6), .op(.minus)],
    [.digit(1), .digit(2), .digit(3), .op(.plus)],
    [.digit(0), .dot, .op(.equal)]
  ]
  var body: some View {
    VStack(spacing: 8) {
      ForEach(pad, id:\.self) { row in
        CalculatorButtonRow(model: self.model, row: row)
      }
    }
  }
}
