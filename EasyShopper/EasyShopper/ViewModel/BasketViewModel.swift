//
//  BasketViewModel.swift
//  EasyShopper
//
//  Created by OSX on 28/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


final class BasketViewModel {
    let basketService = ProductService.shared
    
    private var productsForBasket : PublishSubject<[BasketProduct]>
    
    var showProducts : Observable<[BasketProduct]> {
        return productsForBasket.asObservable()
    }
    
    lazy var products : Observable<[BasketProduct]> = {
        return ProductService.shared.basketProduct.asObservable()
    }()
    
    init(product: PublishSubject<[BasketProduct]>) {
        self.productsForBasket = product
        productsForBasket.onNext(basketService.basketProduct.value)
    }
    
    func deleteAt(index: Int) {
        basketService.delete(at: index)
    }
    
    func temporaryProductArray() -> [BasketProduct] {
        return basketService.basketProduct.value
    }
    
}
