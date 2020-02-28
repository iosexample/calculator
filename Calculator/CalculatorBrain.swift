//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by dong on 28/2/2020.
//  Copyright © 2020 DONG. All rights reserved.
//

import Foundation

enum CalculatorBrain {
  case left(String)
  case leftOp(
    left: String,
    op: CalculatorButtonItem.Op
  )
  case leftOpRight(left: String, op: CalculatorButtonItem.Op, right: String)
  case error
  
//  func apply(item: CalculatorButtonItem) -> CalculatorBrain {
//    switch item {
//    case .digit(let num):
//      return apply(num: num)
//    case .dot:
//      return applyDot()
//    case .op(let op):
//      return apply(op: op)
//    case .command(let command):
//      return apply(command: command)
//    }
//  }
//  
//  private func apply(num: Int) -> CalculatorBrain {
//    switch self {
//    case .left(let left):
//      return .left(left.apply(num: num))
//    case .leftOp(let left, let op):
//      return
//    }
//  }
  
  var output: String {
    let result: String
    switch self {
    case .left(let left): result = left
    default:
      // 其他 case ...
      result = "0"
    }
    
    guard let value = Double(result) else {
      return "Err"
    }
    
    return formatter.string(from: value as NSNumber)!
  }
}

var formatter: NumberFormatter = {
  let f = NumberFormatter()
  f.minimumFractionDigits = 0
  f.maximumFractionDigits = 8
  f.numberStyle = .decimal
  return f
}()

extension String {
  func apply(num: Int) -> String {
    return self == "0" ? "\(num)" : "\(self)\(num)"
  }
}
