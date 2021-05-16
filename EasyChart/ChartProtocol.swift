//
//  ChartProtocol.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import UIKit
/// protocol to define properties needed to represent chart
protocol ChartProtocol where Self: UIView {

    var property: ChartProperty { get set }
    var shapeLayers: ChartShapeLayer { get set }
    var valueBox: Box { get set }
    var rowBox: Box { get set }
    
    init(context: ChartProperty)
    
    func drawChart()
}
