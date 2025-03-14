//
//  ProductListView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

struct ProductListView: View {
    var category: ProductCategory
    @EnvironmentObject var productListVM: ProductListViewModel
    @EnvironmentObject var cartService: CartService
    
    
    @State private var isLoading = true

    @State var column = Array(repeating: GridItem(.flexible(), spacing: 1), count: 2)
    
    var canBuy: Bool = true
    
    var body: some View {
        VStack {
            if isLoading {
                Spacer()
                ProgressView("Đang tải sản phẩm...")
                    .padding()
                Spacer()
            } else {
                VStack {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: column, spacing: 10) {
                            ForEach(productListVM.products, id: \.id) { product in
                                VStack {
                                    AsyncImage(url: URL(string: product.imageUrl)) { image in
                                        image.resizable().scaledToFit()
                                            .clipShape(.rect(cornerRadius: 15))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Spacer()
                                    
                                    VStack(alignment: .leading) {
                                        Text(product.name).font(.headline)
                                        Text("\(NumberFormatter.currencyFormatter.string(from: NSNumber(value: product.price)) ?? "0") VND")
                                            .font(.subheadline)
                                    }
                                }
                                .padding(5)
                                .overlay {
                                    VStack{
                                        Spacer()
                                        CartItemOptionView(product: product)
                                        .padding(.bottom, 70)
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        .onAppear { fetchProducts() }
        .onChange(of: category) { oldValue, newValue in
            fetchProducts()
        }
        .overlay {
            VStack{
                Spacer()
                if !cartService.cartItems.isEmpty {
                    HStack {
                        ZStack {
                            ForEach(Array(cartService.uniqueCategories.enumerated()), id: \.element.id) { index, cate in
                                //let x: CGFloat = cate.xIndex * index
                                Image(cate.imageName)
                                    .resizable()
                                    .padding(5)
                                    .clipShape(Circle())
                                    .frame(width: 50, height: 50)
                                    .offset(x: cate.xIndex)
                                    
                                    
                            }
                            
                        }
                        
                        Spacer()
                        Text("\(NumberFormatter.currencyFormatter.string(from: NSNumber(value: cartService.totalPrice)) ?? "0") VND")
                        
                        Image(systemName: "cart.badge.minus")
                            .font(.body)
                            .onTapGesture {
                                withAnimation {
                                    cartService.resetCart()
                                }
                            }
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .padding()
                }
                
                
            }
        }
    }
    
        
    
    private func fetchProducts() {
        withAnimation {
            productListVM.resetProduct()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            productListVM.loadProducts(for: category)
            withAnimation {
                isLoading = false
            }
        }
    }
}


struct CartItemOptionView: View {
    @EnvironmentObject var cartService: CartService
    
    @State var cartItem: CartItem?
    
    var product: Product
    var body: some View {
        HStack {
            Image(systemName: "plus.circle")
                .resizable()
                .padding(1)
                .background(.green)
                .clipShape(Circle())
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
                .onTapGesture {
                    withAnimation {
                        cartService.addToCart(product)
                    }
                    
                }
            if let cartItem = cartItem {
                Text("\(cartItem.quantity)")
                    .padding(7)
                    .background(.ultraThinMaterial, in: Circle())
            } else {
                Text("0")
                    .padding(7)
                    .background(.ultraThinMaterial, in: Circle())
            }
            
            Image(systemName: "minus.circle")
                .resizable()
                .padding(1)
                .background(.green)
                .clipShape(Circle())
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
                .onTapGesture {
                    withAnimation {
                        cartService.removeFromCart(product)
                    }
                    
                }
        }
        .onAppear{
            self.cartItem = cartService.getCartItem(form: product)
        }
        .onChange(of: cartService.cartItems) { oldValue, newValue in
            self.cartItem = cartService.getCartItem(form: product)
        }
    }
}


extension NumberFormatter {
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // Hiển thị theo kiểu 123.456.789
        formatter.maximumFractionDigits = 0 // Không có số thập phân
        formatter.groupingSeparator = "." // Dùng dấu chấm phân cách hàng nghìn
        return formatter
    }()
}
