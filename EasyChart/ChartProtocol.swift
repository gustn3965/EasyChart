//
//  ChartProtocol.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import UIKit
/// 차트를 나타내기 위한 프로퍼티 및 메서드정의
protocol ChartProtocol where Self: UIView {

    var property: ChartProperty { get set }
    var shapeLayers: ChartShapeLayer { get set }
    var valueBox: Box { get set }
    var rowBox: Box { get set }
    
    init(context: ChartProperty)
    
    func drawChart()
}
