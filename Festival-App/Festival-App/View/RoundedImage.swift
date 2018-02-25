//
//  RoundedImage.swift
//  Festival-App
//
//  Created by Duminica Octavian on 25/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImage: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
}
