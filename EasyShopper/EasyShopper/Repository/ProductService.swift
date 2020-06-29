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
    let api = API()
    
    static let shared = ProductService()
    
    init() {
        fetchRequest()
    }
//    weak var delegate : ProductServiceDelegate?
//
//    private var basketProduct : [BasketProduct] = [] {
//        didSet {
//            delegate?.update()
//        }
//    }
//
//    func getProduct() -> [BasketProduct] {
//        return basketProduct
//    }
//
//    func add(_ product: BasketProduct) {
//        basketProduct.append(product)
//    }
//
//    func deleteProduct(at indexPath: Int) {
//        basketProduct.remove(at: indexPath)
//    }
    
    var disposeBag = DisposeBag()
    
    var basketProduct = BehaviorRelay<[BasketProduct]>(value: [])
    
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
                $0.forEach { prod in
                    print("Product: \(prod._product.name)")
                }
                self?._allProduct.accept($0)
            }).subscribe().disposed(by: disposeBag)
    }
    
}
