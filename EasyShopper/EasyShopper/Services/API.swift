//
//  API.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 27/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


typealias CompletionProduct = (([Product]) -> Void)?
typealias CompletionImage = ((UIImage) -> Void)





struct URLS {
    let demoDataURL = URL(string: "https://run.mocky.io/v3/4e23865c-b464-4259-83a3-061aaee400ba")!
}


struct API {

    let fakeBasket = [BasketProduct(id: "00", product: ProductValue(barcode: "", productDescription: "", id: "", imageURL: "", name: "", retailPrice: 0, costPrice: 0), productImage: UIImage())]
    
    func createRequest(session: URLSession = URLSession.shared) -> Observable<[BasketProduct]> {
        let request = URLRequest(url: URLS().demoDataURL)
        return Observable.create { observer in
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
    
    func objectWithImage(imageUrl: String, session: URLSession = URLSession.shared) -> Observable<UIImage?> {
        let url = URL(fileURLWithPath: imageUrl)
        let request = URLRequest(url: url)
                return Observable.create { observer in
                    
                    let disposable = session.rx.data(request: request)
                        .subscribe { event in
                            switch event {
                                case .error:
                                    observer.onNext(nil)
                                case let .next(data):
    
                                if let image = UIImage(data: data) {
                                        observer.onNext(image)
                                    } else {
                                        observer.onNext(nil)
                                }
                                case .completed:
                                    observer.onCompleted()
                            }
                                
                        }
                        return Disposables.create([disposable])
                    }
    }
    
    func downloadImage(url: URL, completion: @escaping CompletionImage) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
 
}
