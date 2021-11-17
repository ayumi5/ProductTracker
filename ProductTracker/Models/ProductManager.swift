//
//  ProductManager.swift
//  ProductTracker
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import Foundation

class ProductManager {
    var products: [Product]
    var soldProducts = [Product]()
    var client: Client
    
    init(products: [Product], client: Client) {
        self.products = products
        self.client = client
    }
    
    func buyFromSupplier() {
        if products.count > 0 {
            let sold = products.remove(at: 0)
            soldProducts.append(sold)
            client.buy()
        }
    }
    
    func sellToCustomer() {
        client.sell()
    }
    
    func returnFromClient() {
        if client.stockCount > 0 {
            client.returnProduct()
            let returned = soldProducts.remove(at: 0)
            products.append(returned)
        }
    }
}
