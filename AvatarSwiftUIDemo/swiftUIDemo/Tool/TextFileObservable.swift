//
//  TextFileObservable.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/5/5.
//

import Foundation
import SwiftUI
import Combine

class TextFileObservable: ObservableObject {
    
    var limiteNum: Int = 11
    
    private var temp = DeallocPrinter(name: "TextFileObservable")
    
    var limiteIsNum: Bool = false//限制是数字
    @Published public var text: String = "" {
        didSet {
            if text.count > self.limiteNum, oldValue.count <= self.limiteNum {
                text = oldValue
            } else {
                if limiteIsNum {
                    if !text.validate("^[0-9]*$"), oldValue.validate("^[0-9]*$") {
                        text = oldValue
                    }
                }
            }
        }
    }
    
    init(limiteNum: Int, limiteIsNum: Bool) {
        self.limiteNum = limiteNum
        self.limiteIsNum = limiteIsNum
    }
}

extension String {
   func validate(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES%@", regex)
        return predicate.evaluate(with: self)
    }
}
