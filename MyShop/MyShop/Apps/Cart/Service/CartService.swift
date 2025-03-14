//
//  CartService.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI
import FirebaseFirestore

class CartService: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    var totalAmount: Double {
        cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    func addToCart(_ product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            let newItem = CartItem(product: product, quantity: 1)
            cartItems.append(newItem)
        }
    }
    
    func removeFromCart(_ product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            if cartItems[index].quantity > 1 {
                cartItems[index].quantity -= 1
            } else {
                cartItems.remove(at: index)
            }
        }
    }
    
    func checkout(userId: String, completion: @escaping (Bool) -> Void) {
        let order = Order(userId: userId, items: cartItems, totalAmount: totalAmount, timestamp: Date())

        let db = Firestore.firestore()
        do {
            try db.collection("orders").addDocument(from: order)
            cartItems.removeAll() // Xóa giỏ hàng sau khi đặt hàng
            completion(true)
        } catch {
            print("❌ Lỗi khi gửi đơn hàng: \(error.localizedDescription)")
            completion(false)
        }
    }
}
