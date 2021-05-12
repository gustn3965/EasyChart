//
//  FactoryChart.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import Foundation

/// 특정 Chart로 객체만들어주는 팩토리객체
public enum FactoryChart {

    case barChart
    case lineChart
    
    /// Chart 타입에 따라 객체 생성
    func initChartViewBy(_ context: ChartProperty) -> ChartProtocol {
        switch self {
        case .barChart:
            return BarChart(context: context)
        case .lineChart:
            return LineChart(context: context)
        }
    }
}
