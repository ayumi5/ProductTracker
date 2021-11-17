//
//  ProductTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker

class ProductTests: XCTestCase {

    let fiveProducts = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans"), Product(name: "Kona", category: "Coffee beans"), Product(name: "Brazil", category: "Coffee beans")]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Initialization
    func testInit_ProductWithNameAndCategory() {
        let product = Product(name: "Mocha", category: "Coffee beans")
        XCTAssertNotNil(product)
        XCTAssertEqual(product.name, "Mocha")
        XCTAssertEqual(product.category, "Coffee beans")
    }
    
    
    func testInit_SetProductNameAndCount() {
        XCTAssertNotNil(fiveProducts)
        XCTAssertEqual(fiveProducts.count, 5)
    }
}
