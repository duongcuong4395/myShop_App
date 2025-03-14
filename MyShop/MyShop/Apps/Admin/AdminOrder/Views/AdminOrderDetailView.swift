//
//  AdminOrderDetailView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

struct AdminOrderDetailView: View {
    let order: Order
    @ObservedObject var orderService: AdminOrderService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Chi tiết đơn hàng")
                .font(.largeTitle)
                .bold()
            
            Text("Mã đơn: \(order.id ?? "N/A")")
            Text("Tổng tiền: \(order.totalAmount, specifier: "%.2f") đ")
            Text("Trạng thái hiện tại: \(order.status.rawValue)")
            
            List(order.items) { item in
                HStack {
                    Text(item.product.name)
                    Spacer()
                    Text("\(item.quantity) x \(item.product.price, specifier: "%.2f") đ")
                }
            }
            
            HStack {
                Button(action: {
                    orderService.updateOrderStatus(order: order, status: .confirmed)
                }) {
                    Text("Xác nhận đơn")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    orderService.updateOrderStatus(order: order, status: .cancelled)
                }) {
                    Text("Hủy đơn")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}
