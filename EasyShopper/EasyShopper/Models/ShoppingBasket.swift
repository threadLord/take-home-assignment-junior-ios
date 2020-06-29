//
//  ShoppingBasket.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 11/06/2020.
//  Copyright © Marko Mutavdzic. All rights reserved.
//

import UIKit

class BasketProduct {
    var _productImage : UIImage?
    var _product: ProductValue
    var _id: String?
    
    init(id : String, product: ProductValue, productImage: UIImage? = nil) {
        self._id = id
        self._product = product
        self._productImage = productImage
    }
}
