//
//  ShopCategoryViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let heightDivisor: CGFloat = 4.5
}

class ShopCategoryViewController: UIViewController {
    
    lazy var presenter: ShopCategoryPresenter = {
        return ShopCategoryPresenter(view: self)
    }()

    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideMenu()
        hideNavigationBar()
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

extension ShopCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductCategory.rawValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductCategoryCell.identifier, for: indexPath) as? ProductCategoryCell {
            let category = ProductCategory.rawValues[indexPath.row]
            cell.configureCell(category: category)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Segue.toMerch, sender: ProductCategory.rawValues[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height / Constants.heightDivisor
    }
}

extension ShopCategoryViewController: ShopCategoryView {
    func setupSlideMenu() {
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}
