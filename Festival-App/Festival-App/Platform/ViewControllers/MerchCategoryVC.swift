//
//  MerchCategoryVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private enum ProductCategory: String {
    case men = "Men"
    case women = "Women"
    case accessories = "Accesories"
    case music = "Music"
    
    static func getRawValues() -> [String] {
        let categories: [ProductCategory] = [.men, .women, .accessories, .music]
        var rawValues = [String]()
        categories.forEach { (category) in
            rawValues.append(category.rawValue)
        }
        return rawValues
    }
}

class MerchCategoryVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWRevealViewController()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func setUpSWRevealViewController() {
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toMerch {
            if let destinationVC = segue.destination as? MerchVC {
                if let category = sender as? String {
                    destinationVC.category = category
                }
            }
        }
    }
}

extension MerchCategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductCategory.getRawValues().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductCategoryCell.identifier, for: indexPath) as? ProductCategoryCell {
            let category = ProductCategory.getRawValues()[indexPath.row]
            cell.configureCell(category: category)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.toMerch, sender: ProductCategory.getRawValues()[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/4.5;
    }
}
