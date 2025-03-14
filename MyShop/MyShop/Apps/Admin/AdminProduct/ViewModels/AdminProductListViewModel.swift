//
//  AdminProductListViewModel.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

class AdminProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    private let service = ProductService()

    func loadProducts(for category: ProductCategory) {
        service.fetchProducts(for: category) { [weak self] products in
            DispatchQueue.main.async {
                self?.products = products
            }
        }
    }

    func deleteProduct(_ product: Product) {
        service.deleteProduct(product)
        products.removeAll { $0.id == product.id }
    }
}
