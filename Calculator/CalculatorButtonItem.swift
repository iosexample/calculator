//
//  CalculatorButtonItem.swift
//  Calculator
//
//  Created by dong on 27/2/2020.
//  Copyright © 2020 DONG. All rights reserved.
//

import SwiftUI

enum CalculatorButtonItem {
  enum Op: String {
    case plus = "+"
    case minus = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
  }
  
  enum Command: String {
    case clear = "AC"
    case flip = "+/-"
    case percent = "%"
  }
  
  case digit(Int)
  case dot
  case op(Op)
  case command(Command)
  
   var description: String {
    return title
  }
}

extension CalculatorButtonItem {
  var title: String {
    switch self {
    case .digit(let value): return String(value)
    case .dot: return "."
    case .op(let op): return op.rawValue
    case .command(let command): return command.rawValue
    }
  }
  
  var size: CGSize {
    if case .digit(let value) = self, value == 0 {
      return CGSize(width: 88 * 2 + 8, height: 88)
    }
    return CGSize(width: 88, height: 88)
  }
  
  var backgroundColorName: String {
    switch self {
    case .digit, .dot: return "digit.background"
    case .op: return "operator.background"
    case .command: return "command.background"
    }
  }
  
  var foregroundColor: Color {
    switch self {
    case .command: return Color("command.foreground")
    default: return .white
    }
  }
}

extension CalculatorButtonItem: Hashable {}
