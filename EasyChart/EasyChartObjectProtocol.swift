//
//  EasyChartObjectProtocol.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import UIKit

/// 차트를 그리기위해 필요한 데이터의 프로퍼티들을 정의한 protocol
/// - 해당 protocol을 채택한 객체의 배열을 EasyChartView 이니셜라이저에 초기화한다.
/// - 또는 이미 채택한 Object 구조체를 이용해도 된다.
public protocol EasyChartObjectProtocol {
    var value: CGFloat { get set }
    var row: String? { get set }
}
