//
//  ArtistDetailsViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 22/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ArtistDetailsViewController: UIViewController {
    
    lazy var presenter: ArtistDetailsPresenter = {
        return ArtistDetailsPresenter(view: self)
    }()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var innerView: GradientView!
    @IBOutlet weak var closeButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
        presenter.viewDidLoad()
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        innerView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        navigateToArtistsScreen()
    }
    
    @IBAction func onCloseTapped(_ sender: Any) {
        navigateToArtistsScreen()
    }
}

extension ArtistDetailsViewController: ArtistDetailsView {
    func navigateToArtistsScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    func displayArtistName(_ name: String) {
        nameLabel.text = name
    }
    
    func displayGenre(_ genre: String) {
        genreLabel.text = "Genre: \(genre)"
    }
    
    func displayArtistDescription(_ description: String) {
        descriptionTextView.text = description
    }
    
    func displayArtistImage(_ imageURL: String) {
        artistImageView.loadImageUsingCache(withURLString: imageURL)
    }
}
