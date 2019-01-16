//
//  AppNavigationBar.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

@IBDesignable
class AppNavigationBar: UINavigationBar {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        dropShadow()
    }
    
    private func setupView() {
        isTranslucent = false
        barTintColor = UIColor.appBlue
        tintColor = .white
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                               NSAttributedString.Key.font: UIFont(.avenirMedium, of: 17)]
        
    }
    
    private func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.appGray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2
    }
}
