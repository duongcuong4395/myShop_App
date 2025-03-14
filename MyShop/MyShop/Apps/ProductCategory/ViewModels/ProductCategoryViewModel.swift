//
//  ProductCategoryViewModel.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

class ProductCategoryViewModel: ObservableObject {
    @Published var categories: [ProductCategory] = ProductCategory.allCases
}
