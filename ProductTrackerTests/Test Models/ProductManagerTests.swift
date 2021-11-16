//
//  ProductManagerTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker
class ProductManagerTests: XCTestCase {
    
    var manager: ProductManager!
    let client = Client(name: "Cafe")
    var product = Product(name: "Coffee beans")
    
    override func setUpWithError() throws {
        manager = ProductManager(product: product, client: client)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Initialization
    func testInit_ProductAndClientName() {
        XCTAssertEqual(manager.product.name, "Coffee beans")
        XCTAssertEqual(manager.client.name, "Cafe")
    }
    
    func testInit_SupplierProductCount() {
        XCTAssertEqual(manager.product.count, 0)
    }
    
    func testInit_ClientProductCount() {
        XCTAssertEqual(manager.client.stockCount, 0)
        XCTAssertEqual(manager.client.soldCount, 0)
    }

    // MARK: Buy From Supplier
    func testBuyFromSupplier_ProductCountDown_ClientStockCountUp() {
        manager.product.countup()
        XCTAssertEqual(manager.product.count, 1)
        manager.buyFromSupplier()
        
        XCTAssertEqual(manager.product.count, 0)
        XCTAssertEqual(manager.client.stockCount, 1)
    }
    
    func testBuyFromSupplier_ShouldNotBuy_WhenProductCountZero() {
        XCTAssertEqual(manager.product.count, 0)
        manager.buyFromSupplier()
        
        XCTAssertEqual(manager.product.count, 0)
        XCTAssertEqual(manager.client.stockCount, 0)
    }
    
    // MARK: Sell To Customer
    func testSellToCustomer_StockCountDown_SoldCountUp() {
        manager.product.countup()
        manager.buyFromSupplier()
        XCTAssertEqual(manager.client.stockCount, 1)
        XCTAssertEqual(manager.client.soldCount, 0)
        
        manager.sellToCustomer()
        XCTAssertEqual(manager.client.stockCount, 0)
        XCTAssertEqual(manager.client.soldCount, 1)
    }
    
    // MARK: Return From Client
    func testReturnFromClient_ProductCountUp_ClientStockCountDown() {
        manager.product.countup()
        manager.buyFromSupplier()
        XCTAssertEqual(manager.product.count, 0)
        XCTAssertEqual(manager.client.stockCount, 1)
        
        manager.returnFromClient()
        XCTAssertEqual(manager.product.count, 1)
        XCTAssertEqual(manager.client.stockCount, 0)
    }
    
    func testReturnFromClient_ShouldNotReturn_WhenStockCountZero() {
        XCTAssertEqual(manager.client.stockCount, 0)
        XCTAssertEqual(manager.product.count, 0)
        
        manager.returnFromClient()
        XCTAssertEqual(manager.client.stockCount, 0)
        XCTAssertEqual(manager.product.count, 0)
    }
    
    
}
