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
    
    var productManager = ProductManager(product: Product(name: "Coffee", count: 10), client: Client(name: "Cafe"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.productManager = productManager
        productTableView.dataSource = dataSource
        productTableView.delegate = dataSource
        self.initView()
    }
    
    private func initView() {
        productNameLabel.text = productManager.product.name
        clientNameLabel.text = productManager.client.name
        updateView()
    }
    
    private func updateView() {
        productCountLabel.text = String(productManager.product.count)
        stockCountLabel.text = String(productManager.client.stockCount)
        soldCountLabel.text =  String(productManager.client.soldCount)
    }

    @IBAction func returnButtonTapped(_ sender: UIButton) {
        productManager.returnFromClient()
        updateView()
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        productManager.buyFromSupplier()
        updateView()
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        productManager.sellToCustomer()
        updateView()
    }
    
    
}

