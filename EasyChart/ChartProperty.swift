//
//  ChartProperty.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import UIKit

/// Chart should have this struct. this struct is having necessary properties.
struct ChartProperty {
    var frame: CGRect
    var objects: [EasyChartObjectProtocol]
    var isAnimated: Bool
    var color: EasyChartColor
    let key = "strokeEnd"
    
    var minValue: CGFloat?
    var maxValue: CGFloat?
    
    init(frame: CGRect = .zero,
         objects: [EasyChartObjectProtocol],
         isAnimated: Bool = true,
         color: EasyChartColor = EasyChartColor(chartColor: #colorLiteral(red: 0.83, green: 0.25, blue: 0.00, alpha: 1.00),
                                                touchedChartColor: #colorLiteral(red: 0.22, green: 0.24, blue: 0.27, alpha: 1.00))) {
        self.frame = frame
        self.objects = objects
        self.isAnimated = isAnimated
        self.color = color
        caculateMinMax()
    }
    
    private mutating func caculateMinMax() {
        minValue = objects.min(by: {$0.value<$1.value})?.value
        minValue?*=0.8
        maxValue = objects.max(by: {$0.value<$1.value})?.value
    }
}
