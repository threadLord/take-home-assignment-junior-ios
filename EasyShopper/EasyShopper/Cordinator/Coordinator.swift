//
//  Coordinator.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 28/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//


import UIKit

protocol Coordinator {
    var _childCoordinators: [Coordinator] { get set }
    var _navigationController: UINavigationController { get set }

    func start()
}
