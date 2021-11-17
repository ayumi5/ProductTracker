//
//  Client.swift
//  ProductTracker
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import Foundation

class Client {
    var name: String
    var stockCount = 0
    var soldCount = 0
    
    init(name: String) {
        self.name = name
    }
    
    func buy() {
        stockCount += 1
    }
    
    func sell() {
        guard stockCount > 0 else { return }
        stockCount -= 1
        soldCount += 1
    }
    
    func returnProduct() {
        guard stockCount > 0 else { return }
        stockCount -= 1
    }
}
