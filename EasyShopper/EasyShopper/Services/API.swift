//
//  API.swift
//  EasyShopper
//
//  Created by OSX on 27/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation

typealias CompletionHandler = ((Data) -> Void)?
typealias CompletionIdsHandler = (([Int]) -> Void)?

typealias CompletionProduct = (([Product]) -> Void)?

class API {
    
    static let shared = API()
    
    func fetchProducts(url: String, completion: CompletionProduct) -> API {
        
//        if let product = product {
//            completion()
//        }
        
        return API.shared
    }
    
}

