//
//  ProductDetailsViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    lazy var presenter: ProductDetailsPresenter = {
        return ProductDetailsPresenter(view: self)
    }()
    
    @IBOutlet weak var firstSecondaryImageView: UIImageView!
    @IBOutlet weak var secondSecondaryImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigateToProductsScreen()
    }
}

extension ProductDetailsViewController: ProductDetailsView {
    func navigateToProductsScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func displayProductImage(_ URLString: String) {
        mainImageView.loadImageUsingCache(withURLString: URLString)
        firstSecondaryImageView.loadImageUsingCache(withURLString: URLString)
        secondSecondaryImageView.loadImageUsingCache(withURLString: URLString)
    }
    
    func displayPrice(_ price: String) {
        priceLabel.text = "$\(price)"
    }
    
    func displayName(_ name: String) {
        nameLabel.text = name
    }
}
