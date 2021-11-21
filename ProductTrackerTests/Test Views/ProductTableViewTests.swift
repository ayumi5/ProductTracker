//
//  ProductTableViewTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker
class ProductTableViewTests: XCTestCase {

    
    // MARK: Section
    func testTableViewSection_Returns_ProductsCount() {
        let products = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans"), Product(name: "Kona", category: "Coffee beans"), Product(name: "Brazil", category: "Coffee beans")]
        let pm = makeProductManager(products: products)
        let vc = makeTrackViewContoller(productManager: pm)
        let sut = vc.productTableView
        // initial
        XCTAssertEqual(sut?.numberOfRows(inSection: 0), 5)
        
        // plus button tapped
        vc.plusButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut?.numberOfRows(inSection: 0), 4)
        
        // return button tapped
        vc.returnButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut?.numberOfRows(inSection: 0), 5)
    }
    
    
    // MARK: Row
    func testTableViewRow_Removes_FirstProduct_WhenProductSold() {
        let products = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans")]
        let pm = makeProductManager(products: products)
        let vc = makeTrackViewContoller(productManager: pm)
        let sut = vc.productTableView
        let cell1 = sut?.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell1?.textLabel?.text, "Mocha")
        
        vc.plusButton.sendActions(for: .touchUpInside)
        let cell2 = sut?.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell2?.textLabel?.text, "Blue Mountain")
    }
    
    func testTableViewRow_RestoresProductToLastRow_WhenProductReturned() {
        let products = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans")]
        let pm = makeProductManager(products: products)
        let vc = makeTrackViewContoller(productManager: pm)
        let sut = vc.productTableView
        vc.plusButton.sendActions(for: .touchUpInside)
        let cell1 = sut?.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell1?.textLabel?.text, "Blue Mountain")
        
        vc.returnButton.sendActions(for: .touchUpInside)
        let cell2 = sut?.cellForRow(at: IndexPath(row: 1, section: 0))
        XCTAssertEqual(cell2?.textLabel?.text, "Mocha")
    }
    
    // MARK: Cell
    func testCell_RowsAtIndex_ReturnsProductCell() {
        let products = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans")]
        let pm = makeProductManager(products: products)
        let vc = makeTrackViewContoller(productManager: pm)
        let sut = vc.productTableView
        sut?.reloadData()
        
        let cell = sut?.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ProductCell)
    }
    
    func testCell_RowsAtIndex_ShoudDequeueCell() {
        let dataSource = ProductDataSource()
        dataSource.productManager = makeProductManager(products: [Product(name: "Mocha", category: "Coffee beans")])
        let tableMock = ProductTableMock.initMock(dataSource: dataSource)
        
        tableMock.reloadData()
        _ = tableMock.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(tableMock.cellDequeuedProperly)
    }
    
    func testCell_Config_SetCellData() {
        let product = Product(name: "Mocha", category: "Coffee beans")
        let dataSource = ProductDataSource()
        dataSource.productManager = makeProductManager(products: [product])
        let tableMock = ProductTableMock.initMock(dataSource: dataSource)
        tableMock.reloadData()

        let cell = tableMock.cellForRow(at: IndexPath(row: 0, section: 0)) as! ProductCellMock
        
        cell.configName(product)
        XCTAssertEqual(cell.productData, product)
    }
    
}

private extension ProductTableViewTests {
    func makeSUT(productManager: ProductManager) -> UITableView {
        let vc = makeTrackViewContoller(productManager: productManager)
        return vc.productTableView
    }
    
    func makeMockSut(productManager: ProductManager) -> ProductTableMock {
        let dataSource = ProductDataSource()
        dataSource.productManager = productManager
        return ProductTableMock.initMock(dataSource: dataSource)
    }
    
    func makeProductManager(products: [Product] = [], client: Client = Client(name: "Cafe")) -> ProductManager {
        return ProductManager(products: products, client: client)
    }
    
    func makeTrackViewContoller(productManager: ProductManager) -> TrackViewController {
        let trackVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrackViewControllerID") as! TrackViewController
        trackVC.productManager = productManager
        _ = trackVC.view
        return trackVC
    }
}

