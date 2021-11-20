//
//  ProductTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import XCTest

@testable import ProductTracker

class ProductTests: XCTestCase {
    
    // MARK: Initialization
    func testInit_ProductWithNameAndCategory() {
        let product = Product(name: "Mocha", category: "Coffee beans")
        XCTAssertNotNil(product)
        XCTAssertEqual(product.name, "Mocha")
        XCTAssertEqual(product.category, "Coffee beans")
    }
}
