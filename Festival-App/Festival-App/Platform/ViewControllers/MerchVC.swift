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
    
    var category: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProductService.instance.clearProducts()
        startSpinner()
        ProductService.instance.getAllProducts(forCategory: category) { (success) in
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
        navigationController?.popViewController(animated: true)
    }
    
    func startSpinner() {
        LoadingView.startLoading()
    }
    
    func stopSpinner() {
        LoadingView.stopLoading()
    }
}

extension MerchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductService.instance.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.className, for: indexPath) as? ProductCell {
            let product = ProductService.instance.products[indexPath.row]
            cell.configureCell(product: product)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.frame.width / 2) - 20, height: (collectionView.frame.height / 2) - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.95, 0.95, 1)
        
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }, completion: nil)
    }
}
