//
//  ContentViewModel.swift
//  ControlFlowTest
//
//  Created by Barry Bryant on 1/18/21.
//

import SwiftUI

class ContentViewModel : ObservableObject {
  @Published var count = 0
  
  var timer : Timer? = nil
  
  func increment() {
    count+=1
  }

  func reset() {
    count = 0;
  }
  
  private func timerFunc() {
    increment()
  }

  func viewAppear() {
    timer = Timer.scheduledTimer(
      withTimeInterval: 0.25,
      repeats: true) {_ in
        self.timerFunc()
      }
  }
  
      
  func viewDisappear() {
    timer?.invalidate()
  }
  
}
