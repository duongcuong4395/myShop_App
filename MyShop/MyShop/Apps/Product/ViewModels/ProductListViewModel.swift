//
//  ProductListViewModel.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    private let service = ProductService()

    func resetProduct() {
        self.products = []
    }
    
    func loadProducts(for category: ProductCategory) {
        if category == .all {
            service.fetchAllProducts{ [weak self] products in
                DispatchQueue.main.async {
                    self?.products = products
                }
            }
        } else {
            service.fetchProducts(for: category) { [weak self] products in
                DispatchQueue.main.async {
                    self?.products = products
                }
            }
        }
    }
}
