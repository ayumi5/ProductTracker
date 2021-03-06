//
//  ProductManager.swift
//  ProductTracker
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import Foundation


protocol ProductService {
    var products: [Product] { get set }
    var soldProducts: [Product]  { get set }
    var client: Client { get set }
    
    func buyFromSupplier()
    func sellToCustomer()
    func returnFromClient()
}

class ProductManager: ProductService {
    var products: [Product]
    var soldProducts = [Product]()
    var client: Client
    
    init(products: [Product], client: Client) {
        self.products = products
        self.client = client
    }
    
    func buyFromSupplier() {
        if products.count > 0 {
            // TODO: check later
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
            // TODO: check later
            let returned = soldProducts.removeLast()
            products.append(returned)
        }
    }
}
