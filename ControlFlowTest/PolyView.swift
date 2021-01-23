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
  var polyViewModel = PolyViewModel()

  var body: some View {
    GeometryReader { geometry in
      Path { path in
        polyViewModel.angle = polyAngle // setter rotates points

        let scale:CGFloat = min(geometry.size.width, geometry.size.height)

        // Move to last point
        path.move(to: CGPoint(
                    x:polyViewModel.rotatedShape[polyViewModel.numCorners-1].x*scale,
                    y:polyViewModel.rotatedShape[polyViewModel.numCorners-1].y*scale)
        )
        
        // Draw lines to each point
        for i in 0..<polyViewModel.numCorners {
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
      PolyView(polyAngle: Angle(degrees:0.0),
               polyColor: .blue)
    }
}
