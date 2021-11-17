//
//  ProductTableViewTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker
class ProductTableViewTests: XCTestCase {

    var sut: UITableView!
    let client = Client(name: "Cafe")
    let fiveProducts = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans"), Product(name: "Kona", category: "Coffee beans"), Product(name: "Brazil", category: "Coffee beans")]
    var productManager: ProductManager!
    var tableMock: ProductTableMock!
    var dataSource: ProductDataSource!
    
    override func setUpWithError() throws {
        let trackVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrackViewControllerID") as! TrackViewController
        productManager = ProductManager(products: fiveProducts, client: client)
        trackVC.productManager = productManager
        dataSource = ProductDataSource()
        dataSource.productManager = productManager
        tableMock = ProductTableMock.initMock(dataSource: dataSource)
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
        tableMock.reloadData()
        _ = tableMock.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(tableMock.cellDequeuedProperly)
    }
    
    func testCell_Config_SetCellData() {
        tableMock.reloadData()
        
        let cell = tableMock.cellForRow(at: IndexPath(row: 0, section: 0)) as! ProductCellMock
        cell.configName(fiveProducts[0])
        XCTAssertEqual(cell.productData,fiveProducts[0])
    }
    
}

