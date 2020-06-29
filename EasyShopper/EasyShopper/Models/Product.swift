//
//  Product.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 11/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//


import Foundation

struct ProductValue: Codable {
    let barcode, productDescription, id: String
    let imageURL: String
    let name: String
    let retailPrice: Int
    let costPrice: Int?
    
    enum CodingKeys: String, CodingKey {
        case barcode
        case productDescription = "description"
        case id
        case imageURL = "image_url"
        case name
        case retailPrice = "retail_price"
        case costPrice = "cost_price"
    }
}
typealias Product = [String: ProductValue]
