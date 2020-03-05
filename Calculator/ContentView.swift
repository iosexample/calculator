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
  @EnvironmentObject var model: CalculatorModel
  
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
//  @ObservedObject var model = CalculatorModel()
  @EnvironmentObject var model: CalculatorModel
  @State private var editingHistory = false
  @State private var showingResult = false
  
  var body: some View {
    VStack(spacing: 12) {
      Spacer()
      Button("操作履历：\(model.history.count)") {
        print(self.model.historyDetail)
        self.editingHistory = true
      }.sheet(isPresented: self.$editingHistory) {
        HistoryView(model: self.model)
      }
      Text(model.brain.output)
        .font(Font.system(size:76))
        .minimumScaleFactor(0.5)
        .padding(.trailing, 24)
        .lineLimit(1)
        .frame(
          minWidth:0,
          maxWidth: .infinity,
          alignment: .trailing
        )
        .onTapGesture {
          self.showingResult = true
        }.alert(isPresented: self.$showingResult) {
          Alert(
            title: Text(self.model.historyDetail),
            message: Text(self.model.brain.output),
            primaryButton: .destructive(Text("复制")) {
              UIPasteboard.general.string = self.model.brain.output
            },
            secondaryButton: .cancel()
          )
        }
      CalculatorButtonPad()
        .padding(.bottom)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        ContentView().environmentObject(CalculatorModel())
//        ContentView().colorScheme(.light)
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
//  var model: CalculatorModel
  
  
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
        CalculatorButtonRow(row: row)
      }
    }
  }
}

struct HistoryView: View {
  @ObservedObject var model: CalculatorModel
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    VStack {
      if model.totalCount == 0 {
        Text("没有历史")
      } else {
        HStack {
          Text("历史：").font(.headline)
          Text(model.historyDetail).lineLimit(nil)
        }
        HStack {
          Text("显示").font(.headline)
          Text(model.brain.output)
        }
        Slider(
          value: $model.slidingIndex,
          in: 0...Float(model.totalCount),
          step: 1
        )
      }
      Button("关闭") {
        self.presentationMode.wrappedValue.dismiss()
      }
    }.padding()
  }
}
