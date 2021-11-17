//
//  ProductTableViewTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker
class ProductTableViewTests: XCTestCase {

    var trackVC: TrackViewController!
    var sut: UITableView!
    let client = Client(name: "Cafe")
    let fiveProducts = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans"), Product(name: "Kona", category: "Coffee beans"), Product(name: "Brazil", category: "Coffee beans")]
    
    override func setUpWithError() throws {
        trackVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrackViewControllerID") as! TrackViewController
        let productManager = ProductManager(products: fiveProducts, client: client)
        trackVC.productManager = productManager
        trackVC.loadViewIfNeeded()
        sut = trackVC.productTableView
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Section
    func testTableViewSection_Returns_ProductsCount() {
        XCTAssertEqual(sut.numberOfRows(inSection: 0), 5)
    }
    
    // MARK: Cell
    func testCell_RowsAtIndex_ReturnsProductCell() {
        sut.reloadData()
        
        let cell = sut.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ProductCell)
    }
    
    func testCell_RowsAtIndex_ShoudDequeueCell() {
        let mock = ProductTableMock()
        let productManager = ProductManager(products: fiveProducts, client: client)
        let dataSource = ProductDataSource()
        dataSource.productManager = productManager
        mock.dataSource = dataSource
        mock.register(ProductCell.self, forCellReuseIdentifier: "ProductCellID")
        mock.reloadData()
        _ = mock.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mock.cellDequeuedProperly)
    }
    
    func testCell_Config_SetCellData() {
        let mock = ProductTableMock()
        let productManager = ProductManager(products: fiveProducts, client: client)
        let dataSource = ProductDataSource()
        dataSource.productManager = productManager
        mock.dataSource = dataSource
        mock.register(ProductCellMock.self, forCellReuseIdentifier: "ProductCellID")
        mock.reloadData()
        
        let cell = mock.cellForRow(at: IndexPath(row: 0, section: 0)) as! ProductCellMock
        cell.configName(fiveProducts)
        for i in 0..<5 {
            XCTAssertEqual(cell.productArray[i], fiveProducts[i])
        }
    }
    
}

extension ProductTableViewTests {
    class ProductTableMock: UITableView {
        var cellDequeuedProperly = false
        
        override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
            cellDequeuedProperly = true
            return super.dequeueReusableCell(withIdentifier: identifier)
        }
    }
    
    class ProductCellMock: ProductCell {
        var productArray = [Product]()
        override func configName(_ products: [Product]) {
            self.productArray = products
        }
    }
}
