//
//  ArtistCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 22/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {

    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(artist: Artist) {
        artistNameLbl.text = artist.name
        artistImageView.image = UIImage(named: "\(artist.name!)")
        print("\(artist.name)")
    }
}
