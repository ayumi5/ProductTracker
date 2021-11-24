//
//  ProductCellTests.swift
//  ProductTrackerTests
//
//  Created by 宇高あゆみ on 2021/11/17.
//

import XCTest

@testable import ProductTracker
class ProductCellTests: XCTestCase {

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: Configuration
    func testCell_Config_ShouldSetLabelsToProductData() {
        let sut = makeSUT()
        sut.configName(Product(name: "Mocha", category: "Coffee beans"))
        XCTAssertEqual(sut.textLabel?.text, "Mocha")
    }

}

private extension ProductCellTests {
    func makeSUT() -> ProductCell {
        let trackVC = makeTrackViewContoller(productManager: makeProductManager())
        return trackVC.productTableView.dequeueReusableCell(withIdentifier: "ProductCellID", for: IndexPath(row: 0, section: 0)) as! ProductCell
    }
    
    func makeProductManager(products: [Product] = [], client: Client = Client(name: "Cafe")) -> ProductManager {
        return ProductManager(products: products, client: client)
    }
    
    func makeTrackViewContoller(productManager: ProductManager) -> TrackViewController {
        let trackVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrackViewControllerID") as! TrackViewController
        trackVC.productService = productManager
        _ = trackVC.view
        return trackVC
    }
    
    func makeTableviw(productManager: ProductManager) -> UITableView {
        let trackVC = makeTrackViewContoller(productManager: productManager)
        return trackVC.productTableView
    }
}
