//
//  ShopViewModel.swift
//  EasyShopper
//
//  Created by OSX on 28/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ShopViewModel {
    let basketService = ProductService.shared
    
    var disposeBag = DisposeBag()
    let _api : API
    private var _allProducts : PublishSubject<[BasketProduct]>
    private var _basketProducts : PublishSubject<[BasketProduct]>
    
    
    var _allProduct : Observable<[BasketProduct]> {
        return basketService.allProducts.asObservable()
    }
    
    init(allProducts: PublishSubject<[BasketProduct]>,
         basketProducts : PublishSubject<[BasketProduct]>,
        api: API) {
        self._allProducts = allProducts
        self._basketProducts = basketProducts
        self._api = api
//        self._allProduct = _api.createRequest()
        
        
//       _api.createRequest().asDriver(onErrorJustReturn: _api.fakeBasket)
//            .drive(onNext: { all in
//                all.forEach { prod in
//                    print("\(String(describing: prod._product.name))")
//                }
//            })//.disposed(by: disposeBag)
        
        basketService.refreshProducts.onNext(Void())
    }
//    func call() {
//       _api.createRequest()
//           .bind(to: allProducts)
//           .disposed(by: disposeBag)
//
//    }
}

