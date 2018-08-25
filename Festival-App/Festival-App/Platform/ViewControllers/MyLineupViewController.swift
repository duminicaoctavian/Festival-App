//
//  MyLineupViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 24/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class MyLineupViewController: UIViewController {
    
    lazy var presenter: MyLineupPresenter = {
        return MyLineupPresenter(view: self)
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigateToLineupScreen()
    }
    
}

extension MyLineupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.userArtistsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyLineupCell.className, for: indexPath) as? MyLineupCell else { return UITableViewCell() }
        
        presenter.configure(cell, at: indexPath.row)
        
        return cell
    }
}

extension MyLineupViewController: MyLineupView {
    func navigateToLineupScreen() {
        navigationController?.popViewController(animated: true)
    }
}

