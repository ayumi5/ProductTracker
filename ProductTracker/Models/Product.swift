//
//  Product.swift
//  ProductTracker
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import Foundation

struct Product: Equatable {
    var name: String
    var category: String
    
    init(name: String, category: String) {
        self.name = name
        self.category = category
    }
}

