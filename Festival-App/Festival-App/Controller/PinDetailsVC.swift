//
//  PinDetailsVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class PinDetailsVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var thumbnailImgView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var locationTitle: String!
    var locationAddress: String!
    var locationDescription: String!
    var locationImages: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = locationTitle
        addressLbl.text = locationAddress
        descriptionTextView.text = locationDescription
        
        let imageUrl = URL(string: locationImages[0])!
        
        let imageData = NSData(contentsOf: imageUrl)!
        
        let imageToCache = UIImage(data: imageData as Data)
        
        self.thumbnailImgView.image = imageToCache
        
    }
    @IBAction func onClosePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onBookPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onMessageSellerPressed(_ sender: Any) {
    }
    @IBAction func onMorePhotosPressed(_ sender: Any) {
    }
}
