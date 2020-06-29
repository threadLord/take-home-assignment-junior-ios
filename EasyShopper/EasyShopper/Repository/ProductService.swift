//
//  ProductService.swift
//  EasyShopper
//
//  Created by OSX on 29/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductServiceDelegate : class {
    func update()
}

class ProductService {
    
    static let shared = ProductService()
    weak var delegate : ProductServiceDelegate?
    
    private var basketProduct : [BasketProduct] = [] {
        didSet {
            delegate?.update()
        }
    }
    
    
    
    func getProduct() -> [BasketProduct] {
        return basketProduct
    }
    
    func add(_ product: BasketProduct) {
        basketProduct.append(product)
    }
    
    func deleteProduct(at indexPath: Int) {
        basketProduct.remove(at: indexPath)
    }
    
    var baskProduct = BehaviorRelay<[BasketProduct]>(value: [])
    
    func addProduct() 
    
    
}
