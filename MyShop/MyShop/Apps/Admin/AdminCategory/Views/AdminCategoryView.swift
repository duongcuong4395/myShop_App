//
//  AdminCategoryView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

struct AdminCategoryView: View {
    @StateObject private var viewModel = AdminCategoryViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.categories) { category in
                NavigationLink(destination: AdminProductListView(category: category)) {
                    Text(category.rawValue)
                        .font(.title2)
                        .padding()
                }
            }
            .navigationTitle("Quản lý danh mục")
        }
    }
}
