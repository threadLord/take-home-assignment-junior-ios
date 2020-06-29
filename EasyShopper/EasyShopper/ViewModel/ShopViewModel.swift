//
//  ShopViewModel.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 28/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ShopViewModel {
    let basketService = ProductService.shared
   
    var _allProduct : Observable<[BasketProduct]> {
        return basketService.allProducts.asObservable()
    }
    
    init() {
        fetchProducts()
    }

    func addProduct(product: BasketProduct) {
        basketService.add(product: product)
    }
    
    func fetchProducts() {
        basketService.refreshProducts.onNext(Void())
    }
}

