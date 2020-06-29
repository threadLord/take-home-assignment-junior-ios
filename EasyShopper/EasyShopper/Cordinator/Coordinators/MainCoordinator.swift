//
//  MainCoordinator.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 28/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//

import UIKit


class MainCoordinator : Coordinator {
 

    var _childCoordinators: [Coordinator] = [Coordinator]()
    var _navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self._navigationController = navigationController
    }

    enum Navigator {
        case Basket
        case Shop
    }

    
    func start() {
        navigate(.Basket, animated: true)
    }

    func navigate(_ to: Navigator, animated: Bool) {
        let controller = makeController(to)
        _navigationController.pushViewController(controller, animated: animated)
    }
       
    func present(_ controller: Navigator, animated: Bool) {
        let vc = makeController(controller)
        vc.modalPresentationStyle = .pageSheet
        _navigationController.present(vc, animated: animated, completion: nil)
    }
    
    func makeController(_ to : Navigator) -> UIViewController {
        switch to {
        case .Basket:
            let vc = BasketViewController.instantiate()
            vc.mainCoordinator = self
            return vc
            
        case .Shop:
            let vc = ShopViewController.instantiate()
            vc.mainCoordinator = self
            return vc
        }
    }
    
    func dismissLastController() {
        _navigationController.dismiss(animated: true, completion: nil)
    }
}
