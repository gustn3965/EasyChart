//
//  Box.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/10.
//

import Foundation

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
