//
//  TouchedChartProtocol.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import UIKit

/// protocol to define method when touched
protocol TouchedChartProtocol {
    /// Draw `point` at each height when touched
    func drawPointWhenTouched(x:CGFloat, idx: Int, wid: CGFloat)
}

// Already implemented method
extension TouchedChartProtocol where Self: ChartProtocol {
    
    /// Handle depending on touch gesture
    internal func handleGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            shapeLayers.defaultLayer.strokeColor = property.color.touchedChartColor.cgColor
        case .ended:
            shapeLayers.defaultLayer.strokeColor = property.color.chartColor.cgColor
            shapeLayers.touchShapeLayer.path = nil
            shapeLayers.touchPointShapeLayer.path = nil
            valueBox.value = nil
            rowBox.value = nil
        default:
            drawWhenTouched(gesture: gesture)
        }
    }

    /// Draw `Line` and `Point` when chart is touched
    internal func drawWhenTouched(gesture: UILongPressGestureRecognizer ) {
        let location = gesture.location(in: self)
        let width = frame.width/CGFloat(property.objects.count)/2
        var wid = width

        for i in 0..<property.objects.count {
            let left = wid - width/2 >= 0 ? wid-width/2 : 0
            let right = wid + width/2 <= frame.width ? wid+width/2 : frame.width
            
            if (left...right).contains(location.x) {
                drawLineWhenTouched(x: wid)
                drawPointWhenTouched(x: wid, idx: i, wid: width)
                valueBox.value = String(Float(property.objects[i].value))
                rowBox.value = property.objects[i].row
            }
            wid+=width*2
        }
    }

    /// Draw `Line vertical` when chart is touched
    internal func drawLineWhenTouched(x: CGFloat) {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: x, y: 0))
        linePath.addLine(to: CGPoint(x: x, y: frame.height))
        shapeLayers.touchShapeLayer.path = linePath.cgPath
    }
}
