//
//  Model.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/10.
//

import UIKit

/// Struct  conforming `EasyChartObjectProtcol` is used to show dara in chart.  You can use this Object instead of implementing other struct or class conforming EasyChartObjectProtocol.
public struct Object: EasyChartObjectProtocol {
    public var value: CGFloat
    public var row: String?
    public init(value: CGFloat, row: String?) {
        self.value = value
        self.row = row
    }
}
