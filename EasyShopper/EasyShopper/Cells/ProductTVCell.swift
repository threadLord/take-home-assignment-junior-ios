//
//  ProductTVCell.swift
//  EasyShopper
//
//  Created by OSX on 28/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import UIKit

class ProductTVCell: UITableViewCell {

    
    @IBOutlet weak var localImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costPrice: UILabel!
    @IBOutlet weak var retailPrice: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    class var nibID : String {
        return "ProductCell"
    }

    class var cellID : String {
        return "ProductCell"
    }
    
    
    func applyModel(_ product: BasketProduct) {
        localImageView.image = product._productImage
        nameLabel.text = product._product.name
        costPrice.text = String("\(product._product.costPrice)")
        retailPrice.text = String("\(product._product.retailPrice)")
        descriptionLabel.text = product._product.productDescription
    }
    
    
    
}
