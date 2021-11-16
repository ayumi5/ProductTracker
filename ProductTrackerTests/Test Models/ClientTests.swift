//
//  ClientTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker

class ClientTests: XCTestCase {
    let cafeClient = Client(name: "Cafe")
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Initialization
    func testInit_ClientWithName() {
        let client = Client(name: "Cafe")
        XCTAssertNotNil(client)
        XCTAssertEqual(client.name, "Cafe")
    }
    
    func testInit_StockCountZero() {
        XCTAssertEqual(cafeClient.stockCount, 0)
    }
    
    func testInit_SoldCountZero() {
        XCTAssertEqual(cafeClient.soldCount, 0)
    }
    
    // MARK: Buy
    func testBuy_StockCountUp() {
        XCTAssertEqual(cafeClient.stockCount, 0)
        cafeClient.buy()
        XCTAssertEqual(cafeClient.stockCount, 1)
    }
    
    // MARK: Sell
    func testSell_StockCountDown_SoldCountUp() {
        cafeClient.buy()
        XCTAssertEqual(cafeClient.stockCount, 1)
        XCTAssertEqual(cafeClient.soldCount, 0)
        cafeClient.sell()
        XCTAssertEqual(cafeClient.stockCount, 0)
        XCTAssertEqual(cafeClient.soldCount, 1)
    }
    
    func testSell_ShoudNotSell_WhenStockCountZero() {
        XCTAssertEqual(cafeClient.stockCount, 0)
        cafeClient.sell()
        XCTAssertEqual(cafeClient.stockCount, 0)
    }
    
}
