//
//  ShopCategoryPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class ShopCategoryPresenter {
    weak var view: ShopCategoryView?
    
    init(view: ShopCategoryView) {
        self.view = view
    }
    
    func configure(_ itemView: ShopCategoryItemView, at index: Int) {
        let category = ProductCategory.rawValues[index]
        
        itemView.displayCategoryName(category)
        itemView.displayCategoryImage(category)
    }
}
