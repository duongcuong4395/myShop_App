//
//  ProductCategory.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

enum ProductCategory: String, CaseIterable, Identifiable, Codable, Hashable {
    case food = "Thức ăn"
    case iceCream = "Kem"
    case drinks = "Nước uống"

    var id: String { self.rawValue }
}

protocol DataService {
    associatedtype T
    func fetchAll(completion: @escaping ([T]) -> Void)
    func save(item: T)
}
