//
//  BasketViewModel.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 28/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


final class BasketViewModel {
    let basketService = ProductService.shared
    
    lazy var products : Observable<[BasketProduct]> = {
        return ProductService.shared.basketProduct.asObservable()
    }()
    
    lazy var totalPrice : Observable<Int> = {
        return ProductService.shared.totalPrice
    }()
    
    func deleteAt(index: Int) {
        basketService.delete(at: index)
    }
    
    func addProduct(product: BasketProduct) {
        basketService.add(product: product)
    }
    
    func refreshProducts() {
        basketService.refreshProducts.onNext(Void())
    }
}
