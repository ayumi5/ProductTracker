//
//  MockExtension.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/17.
//

import Foundation
import UIKit

@testable import ProductTracker

extension ProductTableViewTests {
    class ProductTableMock: UITableView {
        var cellDequeuedProperly = false
        
        class func initMock(dataSource: ProductDataSource) -> ProductTableMock {
            let mock = ProductTableMock(frame: CGRect(x: 0, y: 0, width: 300, height: 500), style: .plain)
            mock.dataSource = dataSource
            mock.register(ProductCellMock.self, forCellReuseIdentifier: "ProductCellID")
            
            return mock
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
            cellDequeuedProperly = true
            return super.dequeueReusableCell(withIdentifier: identifier)
        }
    }
    
    class ProductCellMock: ProductCell {
        var productData: Product?
        override func configName(_ product: Product) {
            self.productData = product
        }
    }
}
