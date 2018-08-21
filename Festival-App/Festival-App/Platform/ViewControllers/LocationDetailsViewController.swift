//
//  LocationDetailsViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let priceViewCornerRadius: CGFloat = 10.0
    static let offererViewCornerRadius: CGFloat = 5.0
}

class LocationDetailsViewController: UIViewController {
    
    lazy var presenter: LocationDetailsPresenter = {
        return LocationDetailsPresenter(view: self)
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var offererImageView: CircleImage!
    @IBOutlet weak var offererLabel: UILabel!
    @IBOutlet weak var offererNameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundPriceView()
        roundOffererView()
        setupPageControl()
        presenter.viewDidLoad()
    }

    @IBAction func onCloseTapped(_ sender: Any) {
        navigateToAccommodationScreen()
    }
    
    @IBAction func onCallTapped(_ sender: Any) {
        presenter.callNumber()
    }
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}

extension LocationDetailsViewController: LocationDetailsView {
    
    func navigateToAccommodationScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    func displayTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func displayAddress(_ address: String) {
        addressLabel.text = address
    }
    
    func displayPrice(_ price: String) {
        priceLabel.text = "$\(price)"
    }
    
    func displayDescription(_ description: String) {
        descriptionLabel.text = description
    }
    
    func displayImage(_ imageURLString: String, at index: Int) {
        let imageView = makeImageView()
        imageView.loadImageUsingCache(withURLString: imageURLString)
        
        let xPosition = UIScreen.main.bounds.width * CGFloat(index)
        imageView.frame = CGRect(x: xPosition, y: imageScrollView.frame.minY, width: UIScreen.main.bounds.width, height: imageScrollView.frame.height)
        imageScrollView.contentSize.width = UIScreen.main.bounds.width * CGFloat(presenter.numberOfImages)
        
        imageScrollView.addSubview(imageView)
    }
    
    func roundPriceView() {
        priceView.clipsToBounds = true
        priceView.layer.cornerRadius = Constants.priceViewCornerRadius
        priceView.layer.maskedCorners = [.layerMinXMinYCorner]
    }
    
    func roundOffererView() {
        offererNameView.layer.cornerRadius = Constants.offererViewCornerRadius
        offererNameView.clipsToBounds = true
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = presenter.numberOfImages
    }
    
    func displayOffererName(_ username: String) {
        offererLabel.text = username
    }
    
    func displayOferrerProfilePicture(_ URLString: String) {
        offererImageView.loadImageUsingCache(withURLString: URLString)
    }
}

extension LocationDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
