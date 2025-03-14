//
//  ProductListView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

struct ProductListView: View {
    var category: ProductCategory
    @StateObject private var viewModel = ProductListViewModel()
    
    @State private var isLoading = true

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Đang tải sản phẩm...")
                    .padding()
            } else {
                List(viewModel.products) { product in
                    HStack {
                        AsyncImage(url: URL(string: product.imageUrl)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 80)

                        VStack(alignment: .leading) {
                            Text(product.name).font(.headline)
                            Text("\(product.price, specifier: "%.2f") VND").font(.subheadline)
                        }
                        Spacer()
                        Button(action: { print("Thêm vào giỏ hàng") }) {
                            Image(systemName: "cart.badge.plus")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .onAppear { fetchProducts() }
        //.navigationTitle(category.rawValue)
    }
    
    private func fetchProducts() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Giả lập loading
            viewModel.loadProducts(for: category)
            withAnimation {
                isLoading = false
            }
        }
    }
}
