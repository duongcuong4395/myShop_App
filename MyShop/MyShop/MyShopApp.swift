//
//  MyShopApp.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI
import Firebase

@main
struct MyShopApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
