//
//  AdminCategoryViewModel.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

class AdminCategoryViewModel: ObservableObject {
    @Published var categories: [ProductCategory] = ProductCategory.allCases
}
