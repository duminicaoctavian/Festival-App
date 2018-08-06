//
//  ProductDetailsViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let carouselWidth: CGFloat = 200.0
    static let carouselHeight: CGFloat = 300.0
    static let carouselImageCornerRadius: CGFloat = 20.0
    static let carouselSpacing: CGFloat = 1.5
    static let carouselHeightDivisor: CGFloat = 8.0
}

class ProductDetailsViewController: UIViewController {
    
    lazy var presenter: ProductDetailsPresenter = {
        return ProductDetailsPresenter(view: self)
    }()
    
    var startingFrame: CGRect?
    var blackBackgroundView: UIView?
    var startingImageView: UIImageView?
    
    @IBOutlet weak var carouselView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    lazy var carousel: iCarousel = {
        let carousel = iCarousel(frame: CGRect(x: 0, y: view.frame.height / Constants.carouselHeightDivisor, width: view.frame.width, height: Constants.carouselHeight))
        carousel.delegate = self
        carousel.dataSource = self
        carousel.type = .rotary
        carousel.currentItemIndex = 1
        carousel.isPagingEnabled = true
        return carousel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        displayCarousel()
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigateToProductsScreen()
    }
    
    @IBAction func onAddToCartTapped(_ sender: Any) {
        
    }
}

extension ProductDetailsViewController: iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return presenter.product.images.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var roundedImageView: RoundedImage
        
        if let view = view, let imageView = view as? RoundedImage {
            roundedImageView = imageView
        } else {
            roundedImageView = makeImageView()
        }
        
        roundedImageView.loadImageUsingCache(withURLString: presenter.product.images[index])
    
        return roundedImageView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        switch option {
        case .spacing:
            return Constants.carouselSpacing
        default:
            return value
        }
    }
    
    private func makeImageView() -> RoundedImage {
        let imageView = RoundedImage(frame: CGRect(x: 0, y: 0, width: Constants.carouselWidth, height: Constants.carouselHeight))
        imageView.cornerRadius = Constants.carouselImageCornerRadius
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}

extension ProductDetailsViewController: ProductDetailsView {
    func navigateToProductsScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func displayProductImage(_ URLString: String) {
        
    }
    
    func displayPrice(_ price: String) {
        priceLabel.text = "$\(price)"
    }
    
    func displayName(_ name: String) {
        nameLabel.text = name
    }
    
    func displayCarousel() {
        view.addSubview(carousel)
    }
    
    func disableScrollingForCarousel() {
        carousel.isScrollEnabled = false
    }
}
