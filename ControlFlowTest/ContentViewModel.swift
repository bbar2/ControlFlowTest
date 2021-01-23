//
//  ContentViewModel.swift
//  ControlFlowTest
//
//  Created by Barry Bryant on 1/18/21.
//

import SwiftUI

class ContentViewModel : ObservableObject {
  @Published var count = 0
  var acceleration = 0.0;
  
  var timer : Timer? = nil
  
  var poly1Angle:Angle = Angle(degrees: 0.0)
  var poly2Angle:Angle = Angle(degrees: 0.0)
  var poly3Angle:Angle = Angle(degrees: 0.0)

  func increment() {
    count+=1
    acceleration = min (1.0, acceleration+1.0/120.0)
    let angleDegrees = Double(count)*acceleration;
    poly1Angle = Angle(degrees:angleDegrees)
    poly2Angle = Angle(degrees:-1.0*angleDegrees)
    poly3Angle = Angle(degrees:-2.0*angleDegrees)
  }

  func reset() {
    print("reset")
    count = 0
    acceleration = 0.0
  }
  
  private func timerFunc() {
    increment()
  }

  func viewAppear() {
    print("viewAppear")
    timer = Timer.scheduledTimer(
      withTimeInterval: 1.0/60.0,
      repeats: true) {_ in
        self.timerFunc()
      }
  }
  
      
  func viewDisappear() {
    print("viewDisappear")
    timer?.invalidate()
  }
  
}
