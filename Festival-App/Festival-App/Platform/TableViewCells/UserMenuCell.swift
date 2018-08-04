//
//  UserMenuCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class UserMenuCell: UITableViewCell {
    
    static let identifier = "userMenuCell"
    
    @IBOutlet weak var optionLbl: UILabel!
    @IBOutlet weak var optionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(optionName: String) {
        optionLbl.text = optionName
        optionImageView.image = UIImage(named: "\(optionName)")
    }
}
