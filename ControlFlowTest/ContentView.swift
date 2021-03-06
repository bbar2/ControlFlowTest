//
//  ContentView.swift
//  ControlFlowTest
//
//  Created by Barry Bryant on 1/18/21.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel = ContentViewModel()
  
  var body: some View {
    VStack {
      Text("count: \(viewModel.count) ")
      Button("Reset",
             action:{ viewModel.reset() })
      PolyView(polyAngle: viewModel.poly1Angle,
               polyColor:.red,
               pointCount: 6)
      HStack {
        PolyView(polyAngle: viewModel.poly2Angle,
                 polyColor:.green,
                 pointCount: 4)
        PolyView(polyAngle: viewModel.poly3Angle,
                 polyColor:.blue,
                 pointCount: 3)
      }
    }
    .padding()
    .onAppear{
      viewModel.viewAppear()
    }
    .onDisappear{
      viewModel.viewDisappear()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
