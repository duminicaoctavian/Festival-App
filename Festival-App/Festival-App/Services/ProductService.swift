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

class ProductService {
    static let instance = ProductService()
    
    var products = [Product]()
    
    func findAllProductsForCategory(category: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_PRODUCTS)/\(category)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    let array = json["products"].arrayValue
                    for item in array {
                        let _id = item["_id"].stringValue
                        let name = item["name"].stringValue
                        let price = item["price"].stringValue
                        let category = item["category"].stringValue
                        let productImage = item["productImage"].stringValue
                        let product = Product(_id: _id, name: name, price: price, productImage: productImage, category: category)
                        self.products.append(product)
                    }
                    completion(true)
                } catch {
                    debugPrint(error)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearProducts() {
        products.removeAll()
    }
}
