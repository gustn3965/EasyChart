//
//  ChartShapeLayer.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import UIKit

/// Chart가 가져야할 CAShapeLayer를 구성하는 객체
/// - defaultLayer:  기본 차트를 그려주는 Layer
/// - touchShapeLayer: 터치된후 수직으로 직선 그려주는 Layer
/// - touchPointShapeLayer: 터치된 후 각 높이마다 포인트 그려주는 Layer
class ChartShapeLayer {
    let defaultLayer = CAShapeLayer()
    var touchShapeLayer = CAShapeLayer()
    var touchPointShapeLayer = CAShapeLayer()

    let animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue=1
        animation.duration = 0.7
        return animation
    }()
    
    init(color: EasyChartColor) {
        setLayerColor(color)
    }
    
    func setLayerColor(_ color: EasyChartColor) {
        defaultLayer.strokeColor = color.chartColor.cgColor
        defaultLayer.fillColor = UIColor.clear.cgColor
        touchShapeLayer.strokeColor = color.touchedChartColor.cgColor
        touchPointShapeLayer.fillColor = color.chartColor.cgColor
    }
}
