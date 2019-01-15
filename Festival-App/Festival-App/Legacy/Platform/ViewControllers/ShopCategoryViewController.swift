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
        if segue.identifier == Segue.toProducts {
            guard let destinationViewController = segue.destination as? ShopViewController else { return }
            let destinationPresenter = destinationViewController.presenter
            if let category = sender as? String {
                destinationPresenter.category = category
            }
        }
    }
}

extension ShopCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductCategory.rawValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShopCategoryCell.className, for: indexPath) as? ShopCategoryCell else { return UITableViewCell() }
        
        presenter.configure(cell, at: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToProductsScreen(forCategory: ProductCategory.rawValues[indexPath.row])
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
    
    func navigateToProductsScreen(forCategory category: String) {
        performSegue(withIdentifier: Segue.toProducts, sender: category)
    }
}
