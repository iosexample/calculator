//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Dong on 29/2/2020.
//  Copyright © 2020 DONG. All rights reserved.
//

import Foundation
import Combine

class CalculatorModel: ObservableObject {
  
//  let objectWillChange = PassthroughSubject<Void, Never>()
//
//  var brain: CalculatorBrain = .left("0") {
//    willSet { objectWillChange.send() }
//  }
  
  @Published var brain: CalculatorBrain = .left("0")
  
  @Published var history: [CalculatorButtonItem] = []
  
  func apply(_ item: CalculatorButtonItem) {
    brain = brain.apply(item: item)
    history.append(item)
    
    temporaryKept.removeAll()
    slidingIndex = Float(totalCount)
  }
  
  var historyDetail: String {
    return history.map{ $0.title }.joined()
  }
  
  var temporaryKept: [CalculatorButtonItem] = []
  var totalCount: Int {
    history.count + temporaryKept.count
  }
  var slidingIndex: Float = 0 {
    didSet {
      keepHistory(upTo: Int(slidingIndex))
    }
  }
  
  func keepHistory(upTo index: Int) {
    precondition(index <= totalCount, "Out of index.")
    
    let total = history + temporaryKept
    
    history = Array(total[..<index])
    temporaryKept = Array(total[index...])
    
    brain = history.reduce(CalculatorBrain.left("0")) {
      result, item in
      result.apply(item: item)
    }
  }
}
