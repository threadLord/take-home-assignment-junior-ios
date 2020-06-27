//
//  Product.swift
//  EasyShopper
//
//  Created by Morten Bek Ditlevsen on 11/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

//import Foundation
//
//struct Product: Decodable {
//    var id: String
//    
//    
//    
//    
//}


//   let product = try Product(json)

import Foundation
import UIKit

//// MARK: - ProductValue
class Prod {
    var productImage : UIImage?
    var product: Product?
}

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

// MARK: ProductValue convenience initializers and mutators

extension ProductValue {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ProductValue.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        barcode: String? = nil,
        productDescription: String? = nil,
        id: String? = nil,
        imageURL: String? = nil,
        name: String? = nil,
        retailPrice: Int? = nil,
        costPrice: Int?? = nil
    ) -> ProductValue {
        return ProductValue(
            barcode: barcode ?? self.barcode,
            productDescription: productDescription ?? self.productDescription,
            id: id ?? self.id,
            imageURL: imageURL ?? self.imageURL,
            name: name ?? self.name,
            retailPrice: retailPrice ?? self.retailPrice,
            costPrice: costPrice ?? self.costPrice
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias Product = [String: ProductValue]

extension Dictionary where Key == String, Value == ProductValue {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Product.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
