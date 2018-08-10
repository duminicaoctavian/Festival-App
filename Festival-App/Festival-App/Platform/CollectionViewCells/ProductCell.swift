//
//  ProductCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 25/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension ProductCell: ProductItemView {
    func displayName(_ name: String) {
         nameLabel.text = name
    }
    
    func displayPrice(_ price: String) {
        priceLabel.text = "$\(price)"
    }

    func displayImage(_ URLString: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.productImageView.loadImageUsingCache(withURLString: URLString)
            }
        }
    }
}
