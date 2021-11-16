//
//  ProductManager.swift
//  ProductTracker
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import Foundation

class ProductManager {
    var product: Product
    var client: Client
    
    init(product: Product, client: Client) {
        self.product = product
        self.client = client
    }
    
    func buyFromSupplier() {
        if product.count > 0 {
            product.countdown()
            client.buy()
        }
    }
    
    func sellToCustomer() {
        client.sell()
    }
    
    func returnFromClient() {
        client.sell()
        product.countup()
    }
}
