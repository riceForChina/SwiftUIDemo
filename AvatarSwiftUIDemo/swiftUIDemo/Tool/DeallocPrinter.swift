//
//  DeallocPrinter.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/5/5.
//

import Foundation

class DeallocPrinter {
    
    var name: String
    
    init(name: String) {
        self.name = name
        print("构造 \(name) 对象")
    }
    
    deinit {
        print("deinit \(name) 对象")
    }
}
