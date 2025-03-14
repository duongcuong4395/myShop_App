//
//  AppEntryView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

struct AppEntryView: View {
    @StateObject private var authService = AuthService()

    var body: some View {
        if authService.isAuthenticated {
            AdminView()
        } else {
            // CustomerHomeView() // Màn hình khách hàng
            
            EmptyView()
        }
    }
}
