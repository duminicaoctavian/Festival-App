//
//  MerchCategoryVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class MerchCategoryVC: UIViewController {

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

extension MerchCategoryVC: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let merchVC = storyboard?.instantiateViewController(withIdentifier: PRODUCT_VC_IDENTIFIER) as? MerchVC else { return }
        merchVC.category = PRODUCT_CATEGORIES[indexPath.row]
        present(merchVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let modelName = UIDevice.current.modelName
        if modelName == "iPhone 5s" {
            return UIScreen.main.bounds.size.height/4.6;
        }
        return UIScreen.main.bounds.size.height/4.5;
    }
}
