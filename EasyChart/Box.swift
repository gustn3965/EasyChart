//
//  Box.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/10.
//

import Foundation

/// 차트를 터치했을때, 데이터들의 값을 전달하기 위한 객체
final public class Box {
    var value: String? {
        didSet {
            observer?(value)
        }
    }
    
    public init() { }

    private var observer: ((String?) -> Void)?
    
    public func addObserver(observer: @escaping (String?) -> Void) {
        self.observer = observer
    }
}
