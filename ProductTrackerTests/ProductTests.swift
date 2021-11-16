//
//  ProductTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker

class ProductTests: XCTestCase {

    var fiveProducts = Product(name: "Coffee beans", count: 5)
    var zeroProduct =  Product(name: "Coffee beans")
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Initialization
    func testInit_ProductWithName() {
        let product = Product(name: "Coffee beans")
        XCTAssertNotNil(product)
        XCTAssertEqual(product.name, "Coffee beans")
    }
    
    func testInit_SetProductNameAndCount() {
        XCTAssertNotNil(fiveProducts)
        XCTAssertEqual(fiveProducts.count, 5)
    }
    
    // MARK: Count Up
    func testCountUp() {
        XCTAssertEqual(fiveProducts.count, 5)
        fiveProducts.countup()
        XCTAssertEqual(fiveProducts.count, 6)
    }
    
    // MARK: Count Down
    func testCoundDown() {
        XCTAssertEqual(fiveProducts.count, 5)
        fiveProducts.countdown()
        XCTAssertEqual(fiveProducts.count, 4)
    }
    
    func testCountDown_ShouldNotCountDown_WhenProductCountIsZero() {
        zeroProduct.countdown()
        XCTAssertEqual(zeroProduct.count, 0)
    }
    
}
