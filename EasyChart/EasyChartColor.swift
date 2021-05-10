//
//  EasyChartColor.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/10.
//

import UIKit
/// 차트의 기본색과 터치했을때 변하는 색을 담는 객체
public struct EasyChartColor {
    var chartColor: UIColor
    var touchedChartColor: UIColor
    
    
    /// - Parameters:
    ///   - chartColor: 차트의 기본색
    ///   - touchedChartColor: 터치했을때 변하는 색
    public init(chartColor: UIColor,
                touchedChartColor: UIColor) {
        self.chartColor = chartColor
        self.touchedChartColor = touchedChartColor
    }
}
