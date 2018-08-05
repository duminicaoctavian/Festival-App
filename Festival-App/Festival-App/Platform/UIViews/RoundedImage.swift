//
//  RoundedImage.swift
//  Festival-App
//
//  Created by Duminica Octavian on 25/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = cornerRadius
    }
}
