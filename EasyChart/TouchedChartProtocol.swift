//
//  TouchedChartProtocol.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import UIKit
/// Touch됐을때 행할 메서드정의
protocol TouchedChartProtocol {
    /// 터치했을때 각 높이에 포인트를 그리는 메서드
    func drawPointWhenTouched(x:CGFloat, idx: Int, wid: CGFloat)
}

/// 미리 구현한 메서드
extension TouchedChartProtocol where Self: ChartProtocol {
    
    /// 터치했을때 gesture를 상태에 따라 분기하는 메서드
    internal func convertGesture(_ gesture: UILongPressGestureRecognizer) {
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

    /// Touch했을때 부각시키기위해 Line, Circle 호출하여 그리는 메서드
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

    /// 터치된곳에 1자로 그려주는 메서드
    internal func drawLineWhenTouched(x: CGFloat) {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: x, y: 0))
        linePath.addLine(to: CGPoint(x: x, y: frame.height))
        shapeLayers.touchShapeLayer.path = linePath.cgPath
    }
}
