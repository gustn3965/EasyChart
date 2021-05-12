//
//  Model.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/10.
//

import UIKit

/// EasyChartObjectProtocol을 채택했으며, 기본 데이터 타입
public struct Object: EasyChartObjectProtocol {
    public var value: CGFloat
    public var row: String?
    public init(value: CGFloat, row: String?) {
        self.value = value
        self.row = row
    }
}
