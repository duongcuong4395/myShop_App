//
//  CartViewModel.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cartItems: [Product: Int] = [:]

    func addToCart(_ product: Product) {
        cartItems[product, default: 0] += 1
    }

    func removeFromCart(_ product: Product) {
        if let count = cartItems[product], count > 1 {
            cartItems[product] = count - 1
        } else {
            cartItems.removeValue(forKey: product)
        }
    }

    var totalPrice: Double {
        cartItems.reduce(0) { $0 + ($1.key.price * Double($1.value)) }
    }
}
