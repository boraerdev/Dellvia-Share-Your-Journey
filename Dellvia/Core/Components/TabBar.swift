//
//  TabBar.swift
//  Dellvia
//
//  Created by Bora Erdem on 15.08.2022.
//

import Foundation
import SwiftUI

struct tabBar: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
        return Path{ path in
            path.move(to: CGPoint(x: width * 0.9, y: 0))
            path.addQuadCurve(to: CGPoint(x: width, y: height * 0.5), control: CGPoint(x: width, y: 0))
            path.addQuadCurve(to: CGPoint(x: width * 0.9, y: rect.maxY), control: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: width * 0.1, y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: 0, y: height * 0.5), control: CGPoint(x: 0, y: height))
            path.addQuadCurve(to: CGPoint(x: width * 0.1, y: 0), control: .zero)
            
            path.addLine(to: CGPoint(x: width * 0.25, y: 0))
            
            path.addCurve(to: CGPoint(x: width * 0.5, y: height * 0.6),
                          control1: CGPoint(x: width * 0.4, y: 0),
                          control2: CGPoint(x: width * 0.4, y: height * 0.6))
            
            path.addCurve(to: CGPoint(x: width * 0.75, y: 0),
                          control1: CGPoint(x: width * 0.6, y: height * 0.6),
                          control2: CGPoint(x: width * 0.6, y: 0))
            
            path.addLine(to: CGPoint(x: width * 0.9, y: 0))


            
                    
        }
    }
}
