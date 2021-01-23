//
//  PolyViewModel.swift
//  ControlFlowTest
//
//  Created by Barry Bryant on 1/19/21.
//

import SwiftUI

class PolyViewModel {
  var polyPoints:Int
  
  var angle:Angle {
    get { rotateAngle }
    set (newAngle) {
      rotateAngle = newAngle
      rotate()
    }
  }

  private var rotateAngle:Angle = Angle(degrees:0.0)

  // View coordinate system: (0,0) in upper left; (1,1) in lower right
  private let centerOfRotation:CGPoint = CGPoint(x:0.5, y:0.5)
  private let polyRadius = 0.45
  private var definedShape :[CGPoint] = []
  var rotatedShape :[CGPoint] = []

  init(numPoints:Int) {
    polyPoints = numPoints
    
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
    var movedToOrigin:[CGPoint] = Array(repeating: CGPoint(x:0.0, y:0.0), count: polyPoints)
    for i in 0..<polyPoints {
      movedToOrigin[i].x = definedShape[i].x - centerOfRotation.x
      movedToOrigin[i].y = definedShape[i].y - centerOfRotation.y
    }

    // Rotate around origin
    var rotatedAtOrigin:[CGPoint] = Array(repeating: CGPoint(x:0.0, y:0.0), count: polyPoints)
    for i in 0..<polyPoints {
      rotatedAtOrigin[i].x = CGFloat(cos(rotateAngle.radians)) * movedToOrigin[i].x - CGFloat(sin(rotateAngle.radians)) * movedToOrigin[i].y
      rotatedAtOrigin[i].y = CGFloat(sin(rotateAngle.radians)) * movedToOrigin[i].x + CGFloat(cos(rotateAngle.radians)) * movedToOrigin[i].y
    }
    
    // Move origin back to centerOfRotation
    for i in 0..<polyPoints {
      rotatedShape[i].x = rotatedAtOrigin[i].x + centerOfRotation.x
      rotatedShape[i].y = rotatedAtOrigin[i].y + centerOfRotation.y
    }
  }
  
  func viewAppear() {
    print("polyViewAppear")
  }
  
  func viewDisappear() {
    print("polyViewDisappear")
  }

}
