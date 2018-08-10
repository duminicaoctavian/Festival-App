//
//  ShopViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
    
    lazy var presenter: ShopPresenter = {
        return ShopPresenter(view: self)
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        navigateToShopCategoryScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toProductDetails {
            guard let destinationViewController = segue.destination as? ProductDetailsViewController else { return }
            let destinationPresenter = destinationViewController.presenter
            if let product = sender as? Product {
                destinationPresenter.productDidChange(product)
            }
        }
    }
}

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.productsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.className, for: indexPath) as? ProductCell else { return UICollectionViewCell() }
        
        presenter.configure(cell, at: indexPath.row)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.frame.width / 2) - 20, height: (collectionView.frame.height / 2) - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(AnimationParameter.xStartScale,
                                                      AnimationParameter.yStartScale,
                                                      AnimationParameter.zStartScale)
        
        UIView.animate(withDuration: AnimationParameter.duration, animations: {
            cell.layer.transform = CATransform3DMakeScale(AnimationParameter.xEndScale,
                                                          AnimationParameter.yEndScale,
                                                          AnimationParameter.zEndScale)
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToProductDetailsScreen(fromIndex: indexPath.row)
    }
}

extension ShopViewController: ShopView {
    func startActivityIndicator() {
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        LoadingView.stopLoading()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func navigateToShopCategoryScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToProductDetailsScreen(fromIndex index: Int) {
        performSegue(withIdentifier: Segue.toProductDetails, sender: presenter.products[index])
    }
}
