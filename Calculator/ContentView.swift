//
//  ContentView.swift
//  Calculator
//
//  Created by Dong on 25/2/2020.
//  Copyright © 2020 DONG. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("+")
            .font(.system(size:38))
            .foregroundColor(.white)
            .frame(width:88, height:88)
            .background(Color("operator.background"))
        .cornerRadius(44)
//        Text("+")
//            .font(.largeTitle)
//            .foregroundColor(.white)
//            .background(Color.orange)
//            .padding()
//            .background(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
