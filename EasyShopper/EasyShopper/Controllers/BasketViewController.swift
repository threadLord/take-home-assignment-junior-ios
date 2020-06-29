//
//  BasketViewController.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 28/06/2020.
//  Copyright © 2020 Marko Mutavdzic All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BasketViewController: UIViewController, Storyboarded {

    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var shopButton: UIButton!
    
    var totalPriceLabel = UILabel()
    var mainCoordinator : MainCoordinator?
    var disposeBag = DisposeBag()
    var viewModel : BasketViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = BasketViewModel()
        viewModel.refreshProducts()
        setupUI()
        guard let navigationBar = navigationController?.navigationBar else {return}
        let width : CGFloat = 150.0
        totalPriceLabel.frame = CGRect(x: (navigationBar.frame.width - width) / 2, y: 8, width: width, height: 20)
        navigationBar.addSubview(totalPriceLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.refreshProducts()
    }
}

extension BasketViewController : UITableViewDelegate {
    
    func setupUI() {

        viewModel.totalPrice
            .asDriver(onErrorJustReturn: 0)
            .map{String($0)}
            .map{"Total Price: \($0)"}
            .drive(totalPriceLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        shopButton.rx.tap
            .do(onNext: { [weak self] in
                guard let self = self else { return }
                self.mainCoordinator?.present(.Shop, animated: true)
                
                self.viewModel.refreshProducts()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        
        basketTableView.rx.setDelegate(self).disposed(by: disposeBag)
        basketTableView.register(UINib(nibName: ProductTVCell.nibID, bundle: nil), forCellReuseIdentifier: ProductTVCell.cellID)
        
        viewModel.products
            .asDriver(onErrorJustReturn: [])
            .drive(basketTableView.rx.items(cellIdentifier: ProductTVCell.cellID, cellType: ProductTVCell.self)) {  row,element,cell in
                cell.applyModel(element)
            }
            .disposed(by: disposeBag)
        
        basketTableView.rx.itemDeleted
            .asDriver()
            .do(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.deleteAt(index: $0.item)
            })
            .drive()
            .disposed(by: disposeBag)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 300
    }
}
