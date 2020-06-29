//
//  ProductService.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 29/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductService {
    let api = API()
    
    static let shared = ProductService()
    
    init() {
        fetchRequest()
    }

    var disposeBag = DisposeBag()
    
    var basketProduct = BehaviorRelay<[BasketProduct]>(value: [])
    
    var totalPrice : Observable<Int> {
        return basketProduct.map { prod -> Int in
            prod.compactMap { prd -> Int in
                prd._product.retailPrice
            }.reduce(0,+)
        }
    }
    
    func delete(at index: Int) {
        var tempArray = temporaryProductArray()
        tempArray.remove(at: index)
        basketProduct.accept(tempArray)
    }
    
    func add(product: BasketProduct) {
        var tempArray = temporaryProductArray()
        tempArray.append(product)
        basketProduct.accept(tempArray)
    }
    
    func temporaryProductArray() -> [BasketProduct] {
        return basketProduct.value
    }
    
    private var _allProduct = BehaviorRelay<[BasketProduct]>(value: [])
    let refreshProducts = PublishSubject<Void>()
    
    var allProducts: Observable<[BasketProduct]> {
        return _allProduct.asObservable()
    }

    private func fetchRequest() {
        return refreshProducts
            .flatMapLatest {
                return self.api.createRequest()
            }
            .do(onNext: { [weak self] in
                self?._allProduct.accept($0)
            }).subscribe().disposed(by: disposeBag)
    }
    
    func refreshSubscriptions() {
        disposeBag = DisposeBag()
        fetchRequest()
    }
}
