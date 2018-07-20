//
//  LoadingView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 20/07/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class LoadingView: UIView {
    
    static let indicatorView = NVActivityIndicatorView(frame: CGRect.zero, type: .lineScale, color: .white, padding: 30)
    
    static func startLoading() {
        guard let window = UIApplication.shared.delegate?.window as? UIWindow else { return }
        indicatorView.center = window.center
        window.addSubview(indicatorView)
        indicatorView.startAnimating()
    }
    
    static func stopLoading() {
        if !indicatorView.isAnimating { return }
        indicatorView.stopAnimating()
        indicatorView.removeFromSuperview()
    }
    
    static func setLoadingViewColor(color: UIColor) {
        indicatorView.color = color
    }
}

