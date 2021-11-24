//
//  ViewController.swift
//  ProductTracker
//
//  Created by 宇高あゆみ on 2021/11/16.
//

import UIKit

class TrackViewController: UIViewController {

    @IBOutlet weak var productCountLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var stockCountLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var soldCountLabel: UILabel!
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet var dataSource: ProductDataSource!

    var productService: ProductService = ProductManager(products: [Product(name: "Mocha", category: "Coffee beans"), Product(name: "Blue Mountain", category: "Coffee beans"), Product(name: "Kilimanjaro", category: "Coffee beans"), Product(name: "Kona", category: "Coffee beans"), Product(name: "Brazil", category: "Coffee beans")], client: Client(name: "Cafe"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.productService = productService
        productTableView.dataSource = dataSource
        productTableView.delegate = dataSource
        self.initView()
    }
    
    private func initView() {
        productNameLabel.text = productService.products.first?.category
        clientNameLabel.text = productService.client.name
        updateView()
    }
    
    private func updateView() {
        productCountLabel.text = String(productService.products.count)
        stockCountLabel.text = String(productService.client.stockCount)
        soldCountLabel.text =  String(productService.client.soldCount)
        productTableView.reloadData()
    }

    @IBAction func returnButtonTapped(_ sender: UIButton) {
        productService.returnFromClient()
        updateView()
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        productService.buyFromSupplier()
        updateView()
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        productService.sellToCustomer()
        updateView()
    }
    
    
}

