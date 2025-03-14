//
//  AuthService.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import FirebaseAuth

class AuthService: ObservableObject {
    @Published var isAuthenticated = false
    
    func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                self.isAuthenticated = true
                completion(true, nil)
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isAuthenticated = false
        } catch {
            print("❌ Lỗi khi đăng xuất: \(error.localizedDescription)")
        }
    }
    
    func checkAuthState() {
        if Auth.auth().currentUser != nil {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }
}
