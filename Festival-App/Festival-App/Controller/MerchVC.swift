//
//  MerchVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class MerchVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWRevealViewController()
    }
    
    func setUpSWRevealViewController() {
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
}

extension MerchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PRODUCT_CATEGORIES.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PRODUCT_CATEGORY_CELL_IDENTIFIER, for: indexPath) as? ProductCategoryCell {
            let category = PRODUCT_CATEGORIES[indexPath.row]
            cell.configureCell(category: category)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
