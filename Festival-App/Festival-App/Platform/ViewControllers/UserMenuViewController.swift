//
//  UserMenuViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let slideMenuTrailingSpace: CGFloat = 60.0
}

class UserMenuViewController: UIViewController {
    
    lazy var presenter: UserMenuPresenter = {
        return UserMenuPresenter(view: self)
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileImageView: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideMenu()
        addGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @IBAction func onLogoutButtonTapped(_ sender: Any) {
        presenter.logout()
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onImageTapped))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tap)
    }
    
    @objc func onImageTapped() {
        navigateToProfileScreen()
    }
}

extension UserMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserMenuOption.rawValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserMenuOption.rawValues[indexPath.row], for: indexPath) as? UserMenuCell else { return UITableViewCell() }
        
        presenter.configure(cell, at: indexPath.row)
        
        return cell
    }
}

extension UserMenuViewController: UserMenuView {
    func setupSlideMenu() {
        revealViewController().rearViewRevealWidth = view.frame.size.width - Constants.slideMenuTrailingSpace
    }
    
    func displayUserImage(_ URLString: String) {
        profileImageView.loadImageUsingCache(withURLString: URLString)
    }
    
    func navigateToProfileScreen() {
        guard let profileViewController = storyboard?.instantiateViewController(withIdentifier: StoryboardID.profileViewController) as? UINavigationController else { return }
        revealViewController().pushFrontViewController(profileViewController, animated: true)
    }
    
    func navigateToLoginScreen() {
        performSegue(withIdentifier: Segue.logout, sender: self)
    }
}
