//
//  ProductDetailsPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class ProductDetailsPresenter {
    weak var view: ProductDetailsView?
    
    init(view: ProductDetailsView) {
        self.view = view
    }
    
    var product: Product!
    
    func viewDidLoad() {
        guard let product = product else { return }
        
        if product.images.count == 1 {
            view?.disableScrollingForCarousel()
        }
        
        view?.displayName(product.name)
        view?.displayPrice(product.price)
        view?.displayProductImage(product.images[0])
    }
}
