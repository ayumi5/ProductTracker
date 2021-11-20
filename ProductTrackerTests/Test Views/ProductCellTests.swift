//
//  ProductCellTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/17.
//

import XCTest

@testable import ProductTracker
class ProductCellTests: XCTestCase {
    
    var productTableView: UITableView!
    var productManager: ProductManager!
    let client = Client(name: "Cafe")
    let fiveProducts = [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans"), Product(name: "Kona", category: "Coffee beans"), Product(name: "Brazil", category: "Coffee beans")]

    override func setUpWithError() throws {
        let trackVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrackViewControllerID") as! TrackViewController
        productManager = ProductManager(products: fiveProducts, client: client)
        trackVC.productManager = productManager
        trackVC.loadViewIfNeeded()
        productTableView = trackVC.productTableView
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: Configuration
    func testCell_Config_ShouldSetLabelsToProductData_1() {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductCellID", for: IndexPath(row: 0, section: 0)) as! ProductCell
        cell.configName(productManager.products[0])
        XCTAssertEqual(cell.textLabel?.text, "Mocha")
    }
    
    func testCell_Config_ShouldSetLabelsToProductData_2() {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductCellID", for: IndexPath(row: 0, section: 0)) as! ProductCell
        cell.configName(productManager.products[1])
        XCTAssertEqual(cell.textLabel?.text, "Blue Mountain")
    }

}
