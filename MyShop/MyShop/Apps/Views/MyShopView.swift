//
//  MyShopView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

struct MyShopView: View {
    private var facebookBlue: Color = Color(red: 26/255, green: 103/255, blue: 178/255)
    
    @StateObject private var productCategoryVM = ProductCategoryViewModel()
    @StateObject private var productListVM = ProductListViewModel()
    @StateObject var cartService = CartService()
    
    @State var showAddProductView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ProductCategoryView()
                ProductListView(category: productCategoryVM.categorySelected)
            }
            .padding(.horizontal, 5)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("My Shop")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(facebookBlue)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 24) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                showAddProductView.toggle()
                            }

                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                            .font(.system(size: 18, weight: .bold))

                        Image(systemName: "cart")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                            
                    }
                }
            }
        }
        .environmentObject(productCategoryVM)
        .environmentObject(productListVM)
        .environmentObject(cartService)
        .fullScreenCover(isPresented: $showAddProductView) {
            AdminAddProductView()
                .environmentObject(productCategoryVM)
                .environmentObject(productListVM)
        }
    }
}

