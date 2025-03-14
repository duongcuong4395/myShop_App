//
//  AdminOderViews.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

struct AdminOrderListView: View {
    @StateObject private var orderService = AdminOrderService()
    
    var body: some View {
        NavigationView {
            List(orderService.orders) { order in
                NavigationLink(destination: AdminOrderDetailView(order: order, orderService: orderService)) {
                    VStack(alignment: .leading) {
                        Text("Mã đơn: \(order.id ?? "N/A")")
                            .font(.headline)
                        Text("Tổng tiền: \(order.totalAmount, specifier: "%.2f") đ")
                        Text("Trạng thái: \(order.status.rawValue)")
                            .foregroundColor(order.status == .pending ? .orange : (order.status == .confirmed ? .green : .red))
                    }
                }
            }
            .navigationTitle("Quản lý đơn hàng")
            .onAppear {
                orderService.fetchOrders()
            }
        }
    }
}
