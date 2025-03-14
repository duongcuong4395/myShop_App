//
//  AdminLoginView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

struct AdminLoginView: View {
    @StateObject private var authService = AuthService()
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Text("Đăng nhập Admin")
                .font(.largeTitle)
                .bold()
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Mật khẩu", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                authService.login(email: email, password: password) { success, error in
                    if success {
                        print("✅ Đăng nhập thành công!")
                    } else {
                        self.errorMessage = error
                    }
                }
            }) {
                Text("Đăng nhập")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
    }
}
