//
//  Pie.swift
//  Memorize
//
//  Created by Manson Jones on 10/27/20.
//

import SwiftUI

// Shape is Animatable by definition.

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false

    // A property observer
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(x: center.x + radius * cos(CGFloat(startAngle.radians)),
                            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        p.addLine(to: center)
        
        return p
    }
    
}
