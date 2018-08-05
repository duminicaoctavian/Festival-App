//
//  ArtistCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 22/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {
    
    static let identifier = "artistCell"

    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var detailsButton: RoundedButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension ArtistCell: ArtistItemView {
    func displayName(_ name: String) {
        artistNameLabel.text = name
    }
    
    func displayArtistImage(_ URLString: String) {
        artistImageView.loadImageUsingCache(withURLString: URLString)
    }
}
