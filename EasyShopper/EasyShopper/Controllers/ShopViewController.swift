//
//  ShopViewController.swift
//  EasyShopper
//
//  Created by OSX on 28/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShopViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var shopTableView: UITableView!
    @IBOutlet weak var basketButton: UIButton!
    
    var viewModel : ShopViewModel!
    
    var mainCoordinator : MainCoordinator?
        
        var disposeBag = DisposeBag()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let allProducts = PublishSubject<[BasketProduct]>()
            let basketProduct = PublishSubject<[BasketProduct]>()
            let api = API()
            
            viewModel = ShopViewModel(allProducts: allProducts, basketProducts: basketProduct, api: api)
            
            let value = viewModel.basketService.basketProduct.value
            basketProduct.onNext(value)
            
            

            basketButton.rx.tap
                .do(onNext: { [ weak self] in
                    guard let self = self else { return }
                    self.mainCoordinator?.dismissLastController()
                }).subscribe().disposed(by: disposeBag)
            setupUI()
        }
        

}


extension ShopViewController : UITableViewDelegate {
    
    func setupUI() {
        viewModel._allProduct
            .do(onNext: { all in
                all.forEach { prod in
                    print(" PRODUCT -- Id: \(prod._id)")
                }
            }).subscribe().dispose()
        
    }
    
    
}
