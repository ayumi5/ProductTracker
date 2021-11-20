//
//  ProductManagerTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker
class ProductManagerTests: XCTestCase {
    
    // MARK: Initialization
    func testInit_ProductAndClientName() {
        let sut = makeSUT(products: [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Mount Blanc", category: "Cake")], client: Client(name: "Cafe"))
        XCTAssertEqual(sut.products[0].name, "Mocha")
        XCTAssertEqual(sut.products[0].category, "Coffee beans")
        XCTAssertEqual(sut.products[1].name, "Mount Blanc")
        XCTAssertEqual(sut.products[1].category, "Cake")
        XCTAssertEqual(sut.client.name, "Cafe")
    }
    
    func testInit_SupplierProductCount() {
        let sut = makeSUT(products: [Product(name: "Mocha", category: "Coffee beans")], client: Client(name: "Cafe"))
        XCTAssertEqual(sut.products.count, 1)
    }
    
    func testInit_ClientProductCount() {
        let sut = makeSUT()
        XCTAssertEqual(sut.client.stockCount, 0)
        XCTAssertEqual(sut.client.soldCount, 0)
    }

    // MARK: Buy From Supplier
    func testBuyFromSupplier_ProductCountDown_ClientStockCountUp() {
        let sut = makeSUT(products: [Product(name: "Mocha", category: "Coffee beans")])
        XCTAssertEqual(sut.products.count, 1)
        sut.buyFromSupplier()
        
        XCTAssertEqual(sut.products.count, 0)
        XCTAssertEqual(sut.client.stockCount, 1)
    }
    
    func testBuyFromSupplier_ShouldNotBuy_WhenProductCountZero() {
        let sut = makeSUT()
        XCTAssertEqual(sut.products.count, 0)
        sut.buyFromSupplier()
        
        XCTAssertEqual(sut.products.count, 0)
        XCTAssertEqual(sut.client.stockCount, 0)
    }
    
    func testBuyFromSupplier_FirstProductShouldBeSold() {
        let sut = makeSUT(products: [Product(name: "Mocha", category: "Coffee beans")])
        XCTAssertEqual(sut.products.first?.name, "Mocha")
        sut.buyFromSupplier()
        
        XCTAssertEqual(sut.soldProducts.last?.name, "Mocha")
    }
    
    // MARK: Sell To Customer
    func testSellToCustomer_StockCountDown_SoldCountUp() {
        let sut = makeSUT(products: [Product(name: "Mocha", category: "Coffee beans")])
        sut.buyFromSupplier()
        XCTAssertEqual(sut.client.stockCount, 1)
        XCTAssertEqual(sut.client.soldCount, 0)
        
        sut.sellToCustomer()
        XCTAssertEqual(sut.client.stockCount, 0)
        XCTAssertEqual(sut.client.soldCount, 1)
    }
    
    
    // MARK: Return From Client
    func testReturnFromClient_ProductCountUp_ClientStockCountDown() {
        let sut = makeSUT(products: [Product(name: "Mocha", category: "Coffee beans")])
        sut.buyFromSupplier()
        XCTAssertEqual(sut.products.count, 0)
        XCTAssertEqual(sut.client.stockCount, 1)
        
        sut.returnFromClient()
        XCTAssertEqual(sut.products.count, 1)
        XCTAssertEqual(sut.client.stockCount, 0)
    }
    
    func testReturnFromClient_ShouldNotReturn_WhenStockCountZero() {
        let sut = makeSUT(products: [Product(name: "Mocha", category: "Coffee beans")])
        XCTAssertEqual(sut.client.stockCount, 0)
        XCTAssertEqual(sut.products.count, 1)
        
        sut.returnFromClient()
        XCTAssertEqual(sut.client.stockCount, 0)
        XCTAssertEqual(sut.products.count, 1)
    }
    
    func testReturnFromClient_LastSoldProductShouldBeReturned() {
        let sut = makeSUT(products: [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Mount Blanc", category: "Cake")])
        sut.buyFromSupplier()
        sut.buyFromSupplier()
        XCTAssertEqual(sut.soldProducts.last?.name, "Mount Blanc")
        
        sut.returnFromClient()
        XCTAssertEqual(sut.products.first?.name, "Mount Blanc")
    }
    
}

private extension ProductManagerTests {
    func makeSUT(products: [Product] = [], client: Client = Client(name: "Cafe")) -> ProductManager {
        return ProductManager(products: products, client: client)
    }
}
