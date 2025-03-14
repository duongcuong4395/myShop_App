//
//  CartView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

/*
struct CartView: View {
    @StateObject private var cartVM = CartViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(cartVM.cartItems.keys.sorted(by: { $0.name < $1.name }), id: \.id) { product in
                        HStack {
                            Text(product.name)
                            Spacer()
                            Text("\(cartVM.cartItems[product] ?? 0)x")
                            Button(action: { cartVM.removeFromCart(product) }) {
                                Image(systemName: "minus.circle")
                            }
                            Button(action: { cartVM.addToCart(product) }) {
                                Image(systemName: "plus.circle")
                            }
                        }
                    }
                }
                Text("Tổng tiền: \(cartVM.totalPrice, specifier: "%.2f") VND")
                    .font(.title2)
                    .padding()
            }
            .navigationTitle("Giỏ hàng")
        }
    }
}
*/


import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartService: CartService
    @State private var isCheckoutSuccess = false

    var body: some View {
        VStack {
            Text("Giỏ hàng")
                .font(.largeTitle)
                .bold()
                .padding()

            List {
                ForEach(cartService.cartItems) { item in
                    HStack {
                        Text(item.product.name)
                        Spacer()
                        Text("\(item.quantity) x \(item.product.price, specifier: "%.2f") đ")
                        
                        Button(action: { cartService.addToCart(item.product) }) {
                            Image(systemName: "plus.circle")
                        }

                        Button(action: { cartService.removeFromCart(item.product) }) {
                            Image(systemName: "minus.circle")
                        }
                    }
                }
            }

            Text("Tổng tiền: \(cartService.totalAmount, specifier: "%.2f") đ")
                .font(.title2)
                .padding()

            Button("Thanh toán") {
                let userId = "123456" // Tạm thời, sẽ lấy từ Auth
                cartService.checkout(userId: userId) { success in
                    isCheckoutSuccess = success
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }
        .alert(isPresented: $isCheckoutSuccess) {
            Alert(title: Text("✅ Thành công"), message: Text("Đơn hàng đã được đặt thành công!"), dismissButton: .default(Text("OK")))
        }
    }
}
