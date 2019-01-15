//
//  ProductService.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private struct Constants {
    static let productsSerializationKey = "products"
}

class ProductService {
    static let shared = ProductService()
    
    var products = [Product]()
    
    func getAllProducts(forCategory category: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(Route.products)/\(category)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    let array = json[Constants.productsSerializationKey].arrayValue
                    for item in array {
                        let product = Product(json: item)
                        weakSelf.products.append(product)
                    }
                    completion(true)
                } catch {
                    debugPrint(error)
                    completion(false)
                    return
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                return
            }
        }
    }
    
    func clearProducts() {
        products.removeAll()
    }
}
