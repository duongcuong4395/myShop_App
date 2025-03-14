//
//  CartModel.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import Foundation
import FirebaseFirestore

enum OrderStatus: String, Codable {
    case pending = "Chờ xử lý"
    case confirmed = "Đã xác nhận"
    case cancelled = "Đã hủy"
}

struct Order: Codable, Identifiable {
    @DocumentID var id: String?
    let userId: String
    let items: [CartItem]
    let totalAmount: Double
    let timestamp: Date
    var status: OrderStatus = .pending  // Trạng thái mặc định là "Chờ xử lý"
}


struct CartItem: Codable, Identifiable, Equatable {
    var id: String { product.id }
    var product: Product
    var quantity: Int
}
