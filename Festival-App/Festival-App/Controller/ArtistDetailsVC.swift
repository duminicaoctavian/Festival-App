//
//  ArtistDetailsVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 22/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ArtistDetailsVC: UIViewController {

    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var innerView: GradientView!
    @IBOutlet weak var closeBtn: RoundedButton!
    
    var name: String!
    var genre: String!
    var artistDescription: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        closeBtn.setTitle("Close", for: .normal)
        closeBtn.sizeToFit()
    }
    
    func setUpView() {
        genreLbl.text = "Genre: \(genre!)"
        nameLbl.text = name!
        imageView.image = UIImage(named: "\(name!)")
        descriptionTextView.text = artistDescription!
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ArtistDetailsVC.closeTap(_:)))
        innerView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClosePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
