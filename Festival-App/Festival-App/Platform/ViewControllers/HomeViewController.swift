//
//  HomeViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var presenter: HomePresenter = {
        return HomePresenter(view: self)
    }()

    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlideMenu()
        hideNavigationBar()
        
        print(AuthService.instance.user.id, AuthService.instance.user.email, AuthService.instance.user.username, AuthService.instance.user.imageURL, AuthService.instance.authToken, AuthService.instance.isLoggedIn)
    }
    
    @IBAction func onChatTapped(_ sender: Any) {
        navigateToChatScreen()
    }
    
    @IBAction func onBuyTicketsTapped(_ sender: Any) {
        navigateToBuyTickets()
    }
}

extension HomeViewController: HomeView {
    func navigateToBuyTickets() {
        presenter.handleBuyTicketsPage()
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupSlideMenu() {
        menuBtn.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }
    
    func navigateToChatScreen() {
        performSegue(withIdentifier: Segue.toChat, sender: self)
    }
}
