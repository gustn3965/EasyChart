//
//  EasyChartColor.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/10.
//

import UIKit

/// ChartColors are both chartColor and TouchedChartColor.
public struct EasyChartColor {
    var chartColor: UIColor
    var touchedChartColor: UIColor
    
    /// - Parameters:
    ///   - chartColor: default char color
    ///   - touchedChartColor: chart color when touched
    public init(chartColor: UIColor,
                touchedChartColor: UIColor) {
        self.chartColor = chartColor
        self.touchedChartColor = touchedChartColor
    }
}
