//
//  ProductDataSource.swift
//  ProductTracker
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import Foundation
import UIKit

class ProductDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var productManager: ProductManager?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let productManager = productManager else {
            return 0
        }

        return productManager.product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCellID")!
        return cell
    }
    
    
}
