//
//  Box.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/10.
//

import Foundation

/// Box is to publish value to observer when chart is touched.
/// ❌ No longer used. Instead of Box, use Combine.
final class Box {
    var value: String? {
        didSet {
            observer?(value)
        }
    }
    
    init() { }

    private var observer: ((String?) -> Void)?
    
    func addObserver(observer: @escaping (String?) -> Void) {
        self.observer = observer
    }
}
