//
//  BasketViewController.swift
//  EasyShopper
//
//  Created by OSX on 28/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BasketViewController: UIViewController, Storyboarded {

    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var shopButton: UIButton!
    
    var mainCoordinator : MainCoordinator?
    var disposeBag = DisposeBag()
    var viewModel : BasketViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subject = PublishSubject<[BasketProduct]>()
        viewModel = BasketViewModel(product: subject)
        
        setupUI()
        let value = viewModel.basketService.basketProduct.value
        subject.onNext(value)
        
        shopButton.rx.tap.do(onNext: { [weak self] in
            guard let self = self else { return }
            self.mainCoordinator?.present(.Shop, animated: true)
            
            self.viewModel.basketService.refreshProducts.onNext(Void())
            }).subscribe().disposed(by: disposeBag)
    }
    
    
}


extension BasketViewController : UITableViewDelegate {
    
    func setupUI() {
        
        let product = API().fakeBasket
        
        basketTableView.rx.setDelegate(self).disposed(by: disposeBag)
        basketTableView.register(UINib(nibName: ProductTVCell.nibID, bundle: nil), forCellReuseIdentifier: ProductTVCell.cellID)
        
        
        viewModel.showProducts
            .asDriver(onErrorJustReturn: product)
            .drive(basketTableView.rx.items(cellIdentifier: ProductTVCell.cellID, cellType: ProductTVCell.self)) {  row,element,cell in
                
                cell.applyModel(element)
               
            }
            .disposed(by: disposeBag)
        
        viewModel.products
            .do(onNext: { products in
                products.forEach { prod in
                    print("----- : \(prod._product)")
                }
                
            }).subscribe().dispose()
        
    }

    
    
}
