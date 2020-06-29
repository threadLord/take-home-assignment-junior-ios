//
//  API.swift
//  EasyShopper
//
//  Created by OSX on 27/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


typealias CompletionProduct = (([Product]) -> Void)?

//class API {
//
//    static let shared = API()
//
//    func fetchProducts(url: String, completion: CompletionProduct) -> API {
//
////        if let product = product {
////            completion()
////        }
//
//        return API.shared
//    }
//
//}


struct URLS {
    let demoDataURL = URL(string: "https://run.mocky.io/v3/4e23865c-b464-4259-83a3-061aaee400ba")!


}


struct API {

    let fakeBasket = [BasketProduct(id: "00", product: ProductValue(barcode: "", productDescription: "", id: "", imageURL: "", name: "", retailPrice: 0, costPrice: 0), productImage: UIImage())]
    
    func createRequest(session: URLSession = URLSession.shared) -> Observable<[BasketProduct]> {
        let request = URLRequest(url: URLS().demoDataURL)
        return Observable.create { observer in
//            observer.onNext([])
            
            let disposable = session.rx.data(request: request)
                .subscribe { event in
                    switch event {
                        case .error:
                            observer.onNext([])
                        case let .next(data):
                            do {
                                let item = try JSONDecoder().decode(Product.self, from: data)
                                let itemArray = Array(item).compactMap { key, value -> BasketProduct in
                                    return BasketProduct(id: key, product: value)
                                }
                                observer.onNext(itemArray)
                            }
                            catch {
                                observer.onNext([])
                            }
                        case .completed:
                            observer.onCompleted()
                    }
                        
                }
                return Disposables.create([disposable])
            }
    }

    
    
    }
