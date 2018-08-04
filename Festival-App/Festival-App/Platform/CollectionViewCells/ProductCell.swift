//
//  ProductCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 25/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    static let identifier = "productCell"
    
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var data: NSData!
    
    func configureCell(product: Product) {
        
        productNameLbl.text = product.name!
        productPriceLbl.text = "$\(product.price!)"

        let imageUrl = URL(string: product.productImage)!
        
        // Start background thread so that image loading does not make app unresponsive
        // DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData = NSData(contentsOf: imageUrl)!
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.productImageView.image = image
            }
        // }
    }
    
    var didRequestToShowDetails: ((_ cell:UICollectionViewCell) -> ())?
}
