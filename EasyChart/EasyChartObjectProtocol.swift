//
//  EasyChartObjectProtocol.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/12.
//

import UIKit

/// Protocol is defining properties needed to draw chart. Data to be showed in chart should conform this protocol.
/// - Alternative is using `Object`already is conforming this protocol.
public protocol EasyChartObjectProtocol {
    var value: CGFloat { get set }
    var row: String? { get set }
}
