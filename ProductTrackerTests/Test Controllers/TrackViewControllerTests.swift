//
//  TrackViewControllerTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker

class TrackViewControllerTests: XCTestCase {
    
    var sut: TrackViewController!
    var productManager: ProductManager!
    let client = Client(name: "Cafe")
    let fiveProducts = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans"), Product(name: "Kona", category: "Coffee beans"), Product(name: "Brazil", category: "Coffee beans")]

    override func setUpWithError() throws {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrackViewControllerID") as! TrackViewController
        productManager = ProductManager(products: fiveProducts, client: client)
        sut.productManager = productManager
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class..
    }
    
    // MARK: Nil Checks
    func testInitTrackVC_ProductManager_ShoudNotBeNil() {
        XCTAssertNotNil(sut.productManager)
    }
    
    func testInitTrackVC_UIComponent_ShouldNotNil() {
        XCTAssertNotNil(sut.productCountLabel)
        XCTAssertNotNil(sut.productNameLabel)
        XCTAssertNotNil(sut.stockCountLabel)
        XCTAssertNotNil(sut.clientNameLabel)
        XCTAssertNotNil(sut.soldCountLabel)
    }
    
    func testInitTrackVC_ProductTable_ShouldNotBeNil() {
        XCTAssertNotNil(sut.productTableView)
    }
    
    // MARK: Data Source
    func testDataSource_ViewDidLoad_SetsTableViewDataSource() {
        XCTAssertNotNil(sut.productTableView.dataSource)
        XCTAssertTrue(sut.productTableView.dataSource is ProductDataSource)
    }
    
    // MARK: Delegate
    func testDelegate_ViewDidLoad_SetsTableViewDelegate() {
        XCTAssertNotNil(sut.productTableView.delegate)
        XCTAssertTrue(sut.productTableView.delegate is ProductDataSource)
    }
    
    // MARK: Data Service Assumptions
    func testDataSource_ViewDidLoad_SingleDataServiceObject() {
        XCTAssertEqual(sut.productTableView.dataSource as! ProductDataSource, sut.productTableView.delegate as! ProductDataSource)
    }
    
    // MARK: Initialization
    func testInitTrackVC_ProductNameAndCountLabels() {
        XCTAssertEqual(sut.productNameLabel?.text, fiveProducts.first?.category)
        XCTAssertEqual(sut.productCountLabel?.text, "5")
    }
    
    func testInitTrackVC_ClientNameAndCountLabels() {
        XCTAssertEqual(sut.clientNameLabel?.text, client.name)
        XCTAssertEqual(sut.stockCountLabel?.text, "0")
        XCTAssertEqual(sut.soldCountLabel?.text, "0")
    }
    
    func testInitTrackVC_Buttons() {
        XCTAssertEqual(sut.plusButton.titleLabel?.text, "+")
        XCTAssertEqual(sut.minusButton.titleLabel?.text, "-")
        XCTAssertEqual(sut.returnButton.titleLabel?.text, "Return")
    }
    
    // MARK: Select Button
    func testSelect_PlusButton_ShouldProductCountDownAndClientStockCountUp() {
        sut.plusButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.products.count, 4)
        XCTAssertEqual(sut.productManager.client.stockCount, 1)
        XCTAssertEqual(sut.productCountLabel.text, "4")
        XCTAssertEqual(sut.stockCountLabel.text, "1")
    }
    
    func testSelect_PlusButton_ShouldNotDoAnything_WhenProductCountZero() {
        for _ in 0..<5 {
            sut.plusButton.sendActions(for: .touchUpInside)
        }
        XCTAssertEqual(sut.productManager.products.count, 0)
        XCTAssertEqual(sut.productManager.client.stockCount, 5)
        
        sut.plusButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.products.count, 0)
        XCTAssertEqual(sut.productManager.client.stockCount, 5)
        XCTAssertEqual(sut.productCountLabel.text, "0")
        XCTAssertEqual(sut.stockCountLabel.text, "5")
        
    }

    func testSelect_MinusButton_ShoudClientStockCountDownAndClientSoldCountUp() {
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
        XCTAssertEqual(sut.productManager.client.stockCount, 0)
        XCTAssertEqual(sut.productManager.client.soldCount, 0)
        
        sut.minusButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.client.stockCount, 0)
        XCTAssertEqual(sut.productManager.client.soldCount, 0)
        XCTAssertEqual(sut.stockCountLabel.text, "0")
        XCTAssertEqual(sut.soldCountLabel.text, "0")
        
    }
    
    func testSelect_ReturnButton_ShouldProductCountUpAndClientStockCountDown() {
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
        XCTAssertEqual(sut.productManager.products.count, 5)
        XCTAssertEqual(sut.productManager.client.stockCount, 0)
        
        sut.returnButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.productManager.products.count, 5)
        XCTAssertEqual(sut.productManager.client.stockCount, 0)
        XCTAssertEqual(sut.productCountLabel.text, "5")
        XCTAssertEqual(sut.stockCountLabel.text, "0")
    }
}
