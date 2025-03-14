//
//  OrderService.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import Foundation
import FirebaseFirestore

class AdminOrderService: ObservableObject {
    private let db = Firestore.firestore()
    @Published var orders: [Order] = []
    
    func fetchOrders() {
        db.collection("orders")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else { return }
                self.orders = documents.compactMap { try? $0.data(as: Order.self) }
            }
    }
    
    func updateOrderStatus(order: Order, status: OrderStatus) {
        guard let orderId = order.id else { return }
        
        db.collection("orders").document(orderId).updateData(["status": status.rawValue]) { error in
            if let error = error {
                print("❌ Lỗi cập nhật trạng thái đơn hàng: \(error.localizedDescription)")
            } else {
                print("✅ Cập nhật trạng thái đơn hàng thành công!")
            }
        }
    }
}
