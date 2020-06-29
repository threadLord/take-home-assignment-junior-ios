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
    
    private var _allProducts : PublishSubject<[BasketProduct]>
    private var _basketProducts : PublishSubject<[BasketProduct]>
    var _api : API

    init(allProducts: PublishSubject<[BasketProduct]>,
         basketProducts : PublishSubject<[BasketProduct]>,
         api : API
         ) {
        self._allProducts = allProducts
        self._basketProducts = basketProducts
        self._api = api

//        api.createRequest().asDriver(onErrorJustReturn: api.fakeBasket)
//            .drive(onNext: { all in
//                all.forEach { prod in
//                    print("\(String(describing: prod?._product.name))")
//                }
//            }).disposed(by: disposeBag)
        
        
    }
   
    
    
}

