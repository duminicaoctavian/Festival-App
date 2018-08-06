//
//  ProductCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 25/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var data: NSData!
    
    func configureCell(product: Product) {
        
        productNameLbl.text = product.name
        productPriceLbl.text = "$\(product.price)"

        //Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInteractive).async {
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                self.productImageView.loadImageUsingCache(withURLString: product.imageURL)
            }
        }
    }
    
    var didRequestToShowDetails: ((_ cell:UICollectionViewCell) -> ())?
}
