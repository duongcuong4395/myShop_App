//
//  ProductCategoryView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

struct ProductCategoryView: View {
    @StateObject private var viewModel = ProductCategoryViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.categories) { category in
                NavigationLink(destination: ProductListView(category: category)) {
                    Text(category.rawValue)
                        .font(.title2)
                        .padding()
                }
            }
            .navigationTitle("Danh mục sản phẩm")
        }
    }
}
