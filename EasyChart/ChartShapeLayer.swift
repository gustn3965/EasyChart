//
//  ChartShapeLayer.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import UIKit

///  Struct is Having CAShapeLayer properties to draw in chart. Chart should have this class.
/// - defaultLayer:  To draw default chart.
/// - touchShapeLayer: To draw line-vertical chart when touched
/// - touchPointShapeLayer: To draw point chart when touched
struct ChartShapeLayer {
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
    
    mutating func setLayerColor(_ color: EasyChartColor) {
        defaultLayer.strokeColor = color.chartColor.cgColor
        defaultLayer.fillColor = UIColor.clear.cgColor
        touchShapeLayer.strokeColor = color.touchedChartColor.cgColor
        touchPointShapeLayer.fillColor = color.chartColor.cgColor
    }
}
