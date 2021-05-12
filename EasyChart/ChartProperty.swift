//
//  ChartProperty.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import UIKit

/// Chart가 가져야할 프로퍼티들 객체
/// - objects: 차트를 그리기위한 데이터배열
/// - color: 차트의 색을 나타내기 위한 객체
struct ChartProperty {
    var frame: CGRect
    var objects: [EasyChartObjectProtocol]
    var isShowingImmediately: Bool
    var color: EasyChartColor
    let key = "strokeEnd"
    
    var minValue: CGFloat?
    var maxValue: CGFloat?
    
    init(frame: CGRect = .zero,
         objects: [EasyChartObjectProtocol],
         isShowingImmediately: Bool = true,
         color: EasyChartColor = EasyChartColor(chartColor: #colorLiteral(red: 0.83, green: 0.25, blue: 0.00, alpha: 1.00),
                                                touchedChartColor: #colorLiteral(red: 0.22, green: 0.24, blue: 0.27, alpha: 1.00))) {
        self.frame = frame
        self.objects = objects
        self.isShowingImmediately = isShowingImmediately
        self.color = color
        caculateMinMax()
    }
    
    private mutating func caculateMinMax() {
        minValue = objects.min(by: {$0.value<$1.value})?.value
        minValue?*=0.8
        maxValue = objects.max(by: {$0.value<$1.value})?.value
    }
}
