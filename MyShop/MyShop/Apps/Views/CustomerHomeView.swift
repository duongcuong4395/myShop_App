//
//  CustomerHomeView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

/*
struct CustomerHomeView: View {
    @EnvironmentObject var cartService: CartService
    @StateObject private var productService = ProductService()
    
    var body: some View {
        NavigationView {
            List(productService.products) { product in
                HStack {
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.headline)
                        Text("\(product.price, specifier: "%.2f") đ")
                            .font(.subheadline)
                    }
                    Spacer()
                    
                    Button(action: { cartService.addToCart(product) }) {
                        Image(systemName: "cart.badge.plus")
                    }
                }
            }
            .navigationTitle("Menu")
            .onAppear {
                productService.fetchProducts(for: .food) { _ in }
            }
        }
    }
}
*/
