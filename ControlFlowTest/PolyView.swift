//
//  PolyView.swift
//  ControlFlowTest
//
//  Created by Barry Bryant on 1/19/21.
//

import SwiftUI

struct PolyView: View {
  var polyAngle:Angle
  var polyColor:Color
  var pointCount:Int

  var body: some View {
    // I'd rather polyViewModel be outside of body scope, but can't figure out how
    // to pass in the pointCount when outside of body scope -- without moving
    // the initialization (construction) outside of PolyViewModel.init().
    let polyViewModel = PolyViewModel(numPoints: pointCount)
    
    GeometryReader { geometry in
      Path { path in
        polyViewModel.angle = polyAngle // angle set function rotates points

        let scale:CGFloat = min(geometry.size.width, geometry.size.height)

        // Move to last point
        path.move(to: CGPoint(
                    x:polyViewModel.rotatedShape[polyViewModel.polyPoints-1].x*scale,
                    y:polyViewModel.rotatedShape[polyViewModel.polyPoints-1].y*scale)
        )
        
        // Draw lines to each point
        for i in 0..<polyViewModel.polyPoints {
          path.addLine(to: CGPoint(
                        x:polyViewModel.rotatedShape[i].x*scale,
                        y:polyViewModel.rotatedShape[i].y*scale)
          )
        }
      }
      .fill(polyColor)
    }
    .onAppear{
      polyViewModel.viewAppear()
    }
    .onDisappear{
      polyViewModel.viewDisappear()
    }
  }
}

struct PolyView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        PolyView(polyAngle: Angle(degrees:0.0),
                 polyColor: .blue,
                 pointCount: 8)
      }
    }
}
