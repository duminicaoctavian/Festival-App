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
        return ProductService.shared.products.count
    }
    
    var products: [Product] {
        return ProductService.shared.products
    }
    
    init(view: ShopView) {
        self.view = view
    }
    
    func viewWillAppear() {
        guard let category = category else { return }
        ProductService.shared.clearProducts()
        view?.startActivityIndicator()
        
        ProductService.shared.getAllProducts(forCategory: category) { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                weakSelf.view?.stopActivityIndicator()
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.view?.reloadData()
                }
            } else {
                // TODO
            }
        }
    }
    
    func viewWillDisappear() {
        ProductService.shared.clearProducts()
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.reloadData()
        }
    }
    
    func configure(_ itemView: ProductItemView, at index: Int) {
        let product = ProductService.shared.products[index]
        
        itemView.displayName(product.name)
        itemView.displayPrice(product.price)
        itemView.displayImage(product.images[0])
    }
}
