//
//  AdminView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

struct AdminView: View {
    @StateObject private var authService = AuthService()

    var body: some View {
        if authService.isAuthenticated {
            VStack {
                Text("Chào mừng Admin!")
                    .font(.largeTitle)
                
                Button("Đăng xuất") {
                    authService.logout()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        } else {
            AdminLoginView()
        }
    }
}
