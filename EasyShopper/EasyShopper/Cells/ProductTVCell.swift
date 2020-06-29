//
//  ProductTVCell.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 28/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
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
        imageView?.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        imageView?.image = nil
        nameLabel.text = ""
        costPrice.text = ""
        retailPrice.text = ""
        descriptionLabel.text = ""
    }
    
    class var nibID : String {
        return "ProductTVCell"
    }

    class var cellID : String {
        return "ProductCell"
    }
    
    func applyModel(_ product: BasketProduct) {
        localImageView.image = nil
        nameLabel.text = product._product.name
        retailPrice.text = String("Retail Price: \(product._product.retailPrice)")
        descriptionLabel.text = product._product.productDescription
        localImageView.downloadImage(url: product._product.imageURL) { [weak self] image in
            guard let self = self else { return}
            self.localImageView.image = image
        }
        guard let cost = product._product.costPrice else {
            costPrice.text = "No Cost Price"
            return
        }
        costPrice.text = String("Cost Price: \(cost)")
    }
}
