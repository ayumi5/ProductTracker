//
//  Product.swift
//  ProductTracker
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import Foundation

struct Product {
    var name: String
    var count: Int
    
    init(name: String, count: Int = 0) {
        self.name = name
        self.count = count
    }
    
    mutating func countup() {
        self.count += 1
    }
    
    mutating func countdown() {
        if self.count > 0 {
            self.count -= 1
        }
    }
}

