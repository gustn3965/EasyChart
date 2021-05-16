//
//  FactoryChart.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import UIKit

/// Factory chart is to make `specific chart`
public enum FactoryChart {

    case barChart
    case lineChart
    
    /// To make `chart instant` by chart type.
    func initChartViewBy(_ context: ChartProperty) -> ChartProtocol {
        switch self {
        case .barChart:
            return BarChart(context: context)
        case .lineChart:
            return LineChart(context: context)
        }
    }
}
