//
//  ShopPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class ShopPresenter {
    weak var view: ShopView?
    
    var category: String?
    
    var productsCount: Int {
        return ProductService.instance.products.count
    }
    
    init(view: ShopView) {
        self.view = view
    }
    
    func viewWillAppear() {
        guard let category = category else { return }
        ProductService.instance.clearProducts()
        view?.startActivityIndicator()
        
        ProductService.instance.getAllProducts(forCategory: category) { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                weakSelf.view?.stopActivityIndicator()
                weakSelf.view?.reloadData()
            } else {
                // TODO
            }
        }
    }
    
    func viewWillDisappear() {
        ProductService.instance.clearProducts()
        view?.reloadData()
    }
    
    func configure(_ itemView: ProductItemView, at index: Int) {
        let product = ProductService.instance.products[index]
        
        itemView.displayName(product.name)
        itemView.displayPrice(product.price)
        itemView.displayImage(product.imageURL)
    }
}
