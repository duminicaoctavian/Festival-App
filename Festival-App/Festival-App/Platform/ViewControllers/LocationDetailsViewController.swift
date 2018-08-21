//
//  LocationDetailsViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    var locationTitle: String!
    var locationAddress: String!
    var locationDescription: String!
    var locationImages: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = locationTitle
        addressLbl.text = locationAddress
        descriptionTextView.text = locationDescription
        
        for i in 0..<locationImages.count {
            let imageView = UIImageView()
            
            let imageUrl = URL(string: locationImages[i])!
            
            let imageData = NSData(contentsOf: imageUrl)!
            
            let imageToCache = UIImage(data: imageData as Data)
            
            imageView.image = imageToCache
            imageView.contentMode = .scaleAspectFit
            
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: imageScrollView.frame.minY, width: UIScreen.main.bounds.width, height: imageScrollView.frame.height)
            
            imageScrollView.contentSize.width = UIScreen.main.bounds.width * CGFloat(locationImages.count)
            
            imageScrollView.addSubview(imageView)
        }
       
    }

    @IBAction func onClosePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onBookPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onMessageSellerPressed(_ sender: Any) {
    }
}
