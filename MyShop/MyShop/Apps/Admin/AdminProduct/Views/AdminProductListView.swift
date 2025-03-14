//
//  AdminProductListView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

struct AdminProductListView: View {
    var category: ProductCategory
    @StateObject private var viewModel = AdminProductListViewModel()

    var body: some View {
        List {
            ForEach(viewModel.products) { product in
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
                    Button(action: { viewModel.deleteProduct(product) }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .onAppear { viewModel.loadProducts(for: category) }
        .navigationTitle("Sản phẩm: \(category.rawValue)")
        .toolbar {
            Button(action: { /* Chuyển đến màn hình thêm sản phẩm */ }) {
                Image(systemName: "plus")
            }
        }
    }
}
