//
//  ProductCategory.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

enum ProductCategory: String, CaseIterable, Identifiable, Codable, Hashable {
    case all = "Tất cả"
    case food = "Thức ăn"
    case iceCream = "Kem"

    var id: String { self.rawValue }
    
    var imageName: String {
        switch self {
        case .all:
            "all_Icon"
        case .food:
            "food_Icon"
        case .iceCream:
            "ice_cream_Icon"
        
        }
    }
    
    var xIndex: CGFloat {
        switch self {
        case .all:
            0
        case .food:
            5.0
        case .iceCream:
            50.0
        }
    }
}

protocol DataService {
    associatedtype T
    func fetchAll(completion: @escaping ([T]) -> Void)
    func save(item: T)
}
