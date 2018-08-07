//
//  ProfileViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 15/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    lazy var presenter: ProfilePresenter = {
        return ProfilePresenter(view: self)
    }()

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setupSlideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @IBAction func onViewOrderTapped(_ sender: Any) {
        navigateToOrderHistoryScreen()
    }
    
    @IBAction func onMyOffersTapped(_ sender: Any) {
        navigateToMyOffersScreen()
    }
    
    @IBAction func onEditProfileTapped(_ sender: Any) {
        navigateToEditProfileScreen()
    }
}

extension ProfileViewController: ProfileView {
    func navigateToOrderHistoryScreen() {
        
    }
    
    func navigateToMyOffersScreen() {
        
    }
    
    func navigateToEditProfileScreen() {
        let editProfileViewController = EditProfileViewController()
        presenter.editProfilePresenter = editProfileViewController.presenter
        presenter.editProfilePresenter?.delegate = self.presenter
        editProfileViewController.modalPresentationStyle = .custom
        present(editProfileViewController, animated: true, completion: nil)
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupSlideMenu() {
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }
    
    func displayUsername(_ username: String) {
        usernameLabel.text = username
    }
    
    func displayProfileImage(_ URLString: String) {
        profileImageView.loadImageUsingCache(withURLString: URLString)
    }
}
