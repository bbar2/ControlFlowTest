//
//  PolyViewModel.swift
//  ControlFlowTest
//
//  Created by Barry Bryant on 1/19/21.
//

import SwiftUI

class PolyViewModel {
  let polyPoints = 6
  // View coordinate system: (0,0) in upper left; (1,1) in lower right
  let centerOfRotation:CGPoint = CGPoint(x:0.5, y:0.5)
  let polyRadius = 0.45
  var definedShape :[CGPoint] = []
  var rotatedShape :[CGPoint] = []
  var angle:Angle {
    get { rotateAngle }
    set (newAngle) {
      rotateAngle = newAngle
      rotate()
    }
  }
  private var rotateAngle:Angle = Angle(degrees:0.0)

  init() {
    // init unrotated polygon in center of view.
    let dAngle:Angle = Angle(degrees:360.0 / Double(polyPoints))
    for i in 0..<polyPoints {
      definedShape.append(
        CGPoint(
          x: Double(centerOfRotation.x) + polyRadius * cos(Double(i)*dAngle.radians),
          y: Double(centerOfRotation.y) + polyRadius * sin(Double(i)*dAngle.radians)
        )
      )
    }
    rotatedShape = definedShape
  }

  // Rotate around centerOfRotation
  private func rotate() {

    // Move centerOfRotation to origin
    var moveToOrigin:[CGPoint] = Array(repeating: CGPoint(x:0.0, y:0.0), count: polyPoints)
    for i in 0..<polyPoints {
      moveToOrigin[i].x = definedShape[i].x - centerOfRotation.x
      moveToOrigin[i].y = definedShape[i].y - centerOfRotation.y
    }

    // Rotate around origin
    var rotateAtOrigin:[CGPoint] = Array(repeating: CGPoint(x:0.0, y:0.0), count: polyPoints)
    for i in 0..<polyPoints {
      rotateAtOrigin[i].x = CGFloat(cos(rotateAngle.radians)) * moveToOrigin[i].x - CGFloat(sin(rotateAngle.radians)) * moveToOrigin[i].y
      rotateAtOrigin[i].y = CGFloat(sin(rotateAngle.radians)) * moveToOrigin[i].x + CGFloat(cos(rotateAngle.radians)) * moveToOrigin[i].y
    }
    
    // Move origin back to centerOfRotation
    for i in 0..<polyPoints {
      rotatedShape[i].x = rotateAtOrigin[i].x + centerOfRotation.x
      rotatedShape[i].y = rotateAtOrigin[i].y + centerOfRotation.y
    }
  }
  
  func viewAppear() {
    print("polyViewAppear")
  }
  
  func viewDisappear() {
    print("polyViewDisappear")
  }

}
