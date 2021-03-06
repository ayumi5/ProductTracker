//
//  ProductDataSource.swift
//  ProductTracker
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import Foundation
import UIKit

class ProductDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var productService: ProductService?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let productManager = productService else {
            return 0
        }

        return productManager.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productManager = productService else { fatalError() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCellID") as! ProductCell
        cell.configName(productManager.products[indexPath.row])
        return cell
    }
    
    
}
