//
//  ProductModel.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import Foundation

struct Product: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var price: Double
    var imageUrl: String
    var category: ProductCategory
}
