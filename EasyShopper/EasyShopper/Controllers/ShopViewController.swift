//
//  ShopViewController.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 28/06/2020.
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
        viewModel = ShopViewModel()
            
        basketButton.rx.tap
            .do(onNext: { [ weak self] in
                guard let self = self else { return }
                self.mainCoordinator?.dismissLastController()
            })
            .subscribe()
            .disposed(by: disposeBag)
            setupUI()
        }
}


extension ShopViewController : UITableViewDelegate {
    
    func setupUI() {
        
        shopTableView.rx.setDelegate(self).disposed(by: disposeBag)
        shopTableView.register(UINib(nibName: ProductTVCell.nibID, bundle: nil), forCellReuseIdentifier: ProductTVCell.cellID)

        viewModel._allProduct
            .asDriver(onErrorJustReturn: [])
            .do(onNext: { [weak self] in
                guard let self = self else { return }
                if $0.count == 0 {
                    Util.displayYesNoDialog(self, title: "Error", message: "No Internet", yes: {[weak self] in
                        guard let self  = self else { return }
                        self.viewModel.fetchProducts()
                    }) {
                        self.mainCoordinator?.dismissLastController()
                    }
                }
            })
            .drive(shopTableView.rx.items(cellIdentifier: ProductTVCell.cellID, cellType: ProductTVCell.self)) {  row,element,cell in
                cell.applyModel(element)
            }
            .disposed(by: disposeBag)
        
        shopTableView.rx
            .modelSelected(BasketProduct.self)
            .asDriver()
            .do(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.addProduct(product: $0)
            })
            .drive()
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 300
    }
}
