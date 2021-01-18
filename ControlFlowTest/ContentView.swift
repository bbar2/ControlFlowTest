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
        Button("Reset", action:{
          viewModel.reset()
        })
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
