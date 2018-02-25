//
//  MerchVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class MerchVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var category: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProductService.instance.clearProducts()
        startSpinner()
        ProductService.instance.findAllProductsForCategory(category: category) { (success) in
            self.stopSpinner()
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ProductService.instance.clearProducts()
        collectionView.reloadData()
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func startSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
}

extension MerchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductService.instance.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PRODUCT_CELL_IDENTIFIER, for: indexPath) as? ProductCell {
            let product = ProductService.instance.products[indexPath.row]
            cell.configureCell(product: product)
            return cell
        }
        return UICollectionViewCell()
    }
}
