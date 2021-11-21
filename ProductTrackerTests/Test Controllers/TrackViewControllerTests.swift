//
//  TrackViewControllerTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker

class TrackViewControllerTests: XCTestCase {
    
    // MARK: Nil Checks
    func testInitTrackVC_ProductManager_ShoudNotBeNil() {
        XCTAssertNotNil(makeSUT().productManager)
    }
    
    func testInitTrackVC_UIComponent_ShouldNotNil() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.productCountLabel)
        XCTAssertNotNil(sut.productNameLabel)
        XCTAssertNotNil(sut.stockCountLabel)
        XCTAssertNotNil(sut.clientNameLabel)
        XCTAssertNotNil(sut.soldCountLabel)
    }
    
    func testInitTrackVC_ProductTable_ShouldNotBeNil() {
        XCTAssertNotNil(makeSUT().productTableView)
    }
    
    // MARK: Data Source
    func testDataSource_ViewDidLoad_SetsTableViewDataSource() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.productTableView.dataSource)
        XCTAssertTrue(sut.productTableView.dataSource is ProductDataSource)
    }
    
    // MARK: Delegate
    func testDelegate_ViewDidLoad_SetsTableViewDelegate() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.productTableView.delegate)
        XCTAssertTrue(sut.productTableView.delegate is ProductDataSource)
    }
    
    // MARK: Data Service Assumptions
    func testDataSource_ViewDidLoad_SingleDataServiceObject() {
        let sut = makeSUT()
        XCTAssertEqual(sut.productTableView.dataSource as! ProductDataSource, sut.productTableView.delegate as! ProductDataSource)
    }
    
    // MARK: Initialization
    func testInitTrackVC_ProductNameAndCountLabels() {
        let products = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans"), Product(name: "Kona", category: "Coffee beans"), Product(name: "Brazil", category: "Coffee beans")]
        let sut = makeSUT(products: products)
        XCTAssertEqual(sut.productNameLabel?.text, "Coffee beans")
        XCTAssertEqual(sut.productCountLabel?.text, "5")
    }
    
    func testInitTrackVC_ClientNameAndCountLabels() {
        let client = Client(name: "Bookshop")
        let sut = makeSUT(client: client)
        XCTAssertEqual(sut.clientNameLabel?.text, "Bookshop")
        XCTAssertEqual(sut.stockCountLabel?.text, "0")
        XCTAssertEqual(sut.soldCountLabel?.text, "0")
    }
    
    func testInitTrackVC_Buttons() {
        let sut = makeSUT()
        XCTAssertEqual(sut.plusButton.titleLabel?.text, "+")
        XCTAssertEqual(sut.minusButton.titleLabel?.text, "-")
        XCTAssertEqual(sut.returnButton.titleLabel?.text, "Return")
    }
    
    // MARK: Select Button
    func testSelect_PlusButton_ShouldProductCountDownAndClientStockCountUp() {
        let products = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans")]
        let sut = makeSUT(products: products)
        sut.plusButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.products.count, 2)
        XCTAssertEqual(sut.productManager.client.stockCount, 1)
        XCTAssertEqual(sut.productCountLabel.text, "2")
        XCTAssertEqual(sut.stockCountLabel.text, "1")
    }
    
    func testSelect_PlusButton_ShouldNotDoAnything_WhenProductCountZero() {
        let sut = makeSUT()
        
        sut.plusButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.products.count, 0)
        XCTAssertEqual(sut.productManager.client.stockCount, 0)
        XCTAssertEqual(sut.productCountLabel.text, "0")
        XCTAssertEqual(sut.stockCountLabel.text, "0")
        
    }

    func testSelect_MinusButton_ShoudClientStockCountDownAndClientSoldCountUp() {
        let products = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans")]
        let sut = makeSUT(products: products)
        sut.plusButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.client.stockCount, 1)
        XCTAssertEqual(sut.productManager.client.soldCount, 0)
        
        sut.minusButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.client.stockCount, 0)
        XCTAssertEqual(sut.productManager.client.soldCount, 1)
        XCTAssertEqual(sut.stockCountLabel.text, "0")
        XCTAssertEqual(sut.soldCountLabel.text, "1")
    }
    
    func testSelect_MinusButton_ShouldNotDoAnything_WhenClientStockCountZero() {
        let sut = makeSUT()
        sut.minusButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.client.stockCount, 0)
        XCTAssertEqual(sut.productManager.client.soldCount, 0)
        XCTAssertEqual(sut.stockCountLabel.text, "0")
        XCTAssertEqual(sut.soldCountLabel.text, "0")
        
    }
    
    func testSelect_ReturnButton_ShouldProductCountUpAndClientStockCountDown() {
        let products = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans"), Product(name: "Kona", category: "Coffee beans"), Product(name: "Brazil", category: "Coffee beans")]
        let sut = makeSUT(products: products)
        sut.plusButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.products.count, 4)
        XCTAssertEqual(sut.productManager.client.stockCount, 1)
        
        sut.returnButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.products.count, 5)
        XCTAssertEqual(sut.productManager.client.stockCount, 0)
        XCTAssertEqual(sut.productCountLabel.text, "5")
        XCTAssertEqual(sut.stockCountLabel.text, "0")
    }
    
    func testSelect_ReturnButton_ShouldNotDoAnything_WhenClientStockCountZero() {
        let products = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans"), Product(name: "Kona", category: "Coffee beans"), Product(name: "Brazil", category: "Coffee beans")]
        let sut = makeSUT(products: products)
        
        sut.returnButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.products.count, 5)
        XCTAssertEqual(sut.productManager.client.stockCount, 0)
        XCTAssertEqual(sut.productCountLabel.text, "5")
        XCTAssertEqual(sut.stockCountLabel.text, "0")
    }
}

private extension TrackViewControllerTests {
    func makeSUT(products: [Product] = [], client: Client = Client(name: "Cafe")) -> TrackViewController {
        let sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrackViewControllerID") as! TrackViewController
        sut.productManager = ProductManager(products: products, client: client)
        _ = sut.view
        return sut
    }
}
