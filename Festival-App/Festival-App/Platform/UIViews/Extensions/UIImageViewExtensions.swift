//
//  UIImageViewExtensions.swift
//  Festival-App
//
//  Created by Octavian Duminica on 04/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCache(withURLString URLString: String, completion: CompletionHandler? = nil) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: URLString as NSString) {
            self.image = cachedImage
            completion?(true)
            return
        }
        
        guard let URL = URL(string: URLString) else { completion?(false); return }

        URLSession.shared.dataTask(with: URL) { [weak self] (data, response, error) in
            guard let weakSelf = self else { completion?(false); return }
            
            if error != nil {
                print(error as Any)
                completion?(false)
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data, let downloadedImage = UIImage(data: data) else { completion?(false); return }
                imageCache.setObject(downloadedImage, forKey: URLString as NSString)
                
                weakSelf.image = downloadedImage
            }
            completion?(true)
        }.resume()
    }
}
