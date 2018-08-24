//
//  MyLineupViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 24/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class MyLineupViewController: UIViewController {
    
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension MyLineupViewController: MyLineupView {
    func navigateToLineupScreen() {
        navigationController?.popViewController(animated: true)
    }
}

