//
//  ClientTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker

class ClientTests: XCTestCase {
    
    // MARK: Initialization
    func testInit_ClientWithName() {
        let sut = makeSUT(name: "Cafe")
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.name, "Cafe")
    }
    
    func testInit_StockCountZero() {
        XCTAssertEqual(makeSUT().stockCount, 0)
    }
    
    func testInit_SoldCountZero() {
        XCTAssertEqual(makeSUT().soldCount, 0)
    }
    
    // MARK: Buy
    func testBuy_StockCountUp() {
        let sut = makeSUT()
        XCTAssertEqual(sut.stockCount, 0)
        sut.buy()
        XCTAssertEqual(sut.stockCount, 1)
    }
    
    // MARK: Sell
    func testSell_StockCountDown_SoldCountUp() {
        let sut = makeSUT()
        sut.buy()
        XCTAssertEqual(sut.stockCount, 1)
        XCTAssertEqual(sut.soldCount, 0)
        sut.sell()
        XCTAssertEqual(sut.stockCount, 0)
        XCTAssertEqual(sut.soldCount, 1)
    }
    
    func testSell_ShoudNotSell_WhenStockCountZero() {
        let sut = makeSUT()
        XCTAssertEqual(sut.stockCount, 0)
        sut.sell()
        XCTAssertEqual(sut.stockCount, 0)
    }
    
    // MARK: Return
    func testReturn_StockCountDown() {
        let sut = makeSUT()
        sut.buy()
        XCTAssertEqual(sut.stockCount, 1)
        sut.returnProduct()
        XCTAssertEqual(sut.stockCount, 0)
    }
    
    func testReturn_ShoundNotReturn_WhenStockCountZero() {
        let sut = makeSUT()
        XCTAssertEqual(sut.stockCount, 0)
        sut.returnProduct()
        XCTAssertEqual(sut.stockCount, 0)
    }
    
    
}

extension ClientTests {
    // MARK: Helper
    func makeSUT(name: String = "") -> Client {
        return Client(name: name)
    }
}
