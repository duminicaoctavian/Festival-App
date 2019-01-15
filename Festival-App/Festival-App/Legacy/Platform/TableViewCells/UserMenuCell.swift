//
//  UserMenuCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class UserMenuCell: UITableViewCell {
    
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var optionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension UserMenuCell: UserMenuItemView {
    func displayOptionName(_ name: String) {
        optionLabel.text = name
    }
    
    func displayOptionImage(_ imageName: String) {
        optionImageView.image = UIImage(named: imageName)
    }
}
