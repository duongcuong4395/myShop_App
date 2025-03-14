//
//  ProductService.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import FirebaseFirestore
//import FirebaseFirestoreSwift

class ProductService {
    private let db = Firestore.firestore()

    
    // Lấy All sản phẩm
    func fetchAllProducts(completion: @escaping ([Product]) -> Void) {
        db.collection("products")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    completion([])
                    return
                }
                let products = documents.compactMap { doc -> Product? in
                    try? doc.data(as: Product.self)
                }
                completion(products)
            }
    }
    
    // Lấy danh sách sản phẩm theo danh mục
    func fetchProducts(for category: ProductCategory
                       , completion: @escaping ([Product]) -> Void) {
        db.collection("products")
            .whereField("category", isEqualTo: category.rawValue)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    completion([])
                    return
                }
                let products = documents.compactMap { doc -> Product? in
                    try? doc.data(as: Product.self)
                }
                completion(products)
            }
    }

    // Xóa sản phẩm khỏi Firestore
    func deleteProduct(_ product: Product) {
        db.collection("products").document(product.id).delete { error in
            if let error = error {
                print("❌ Lỗi khi xóa sản phẩm: \(error.localizedDescription)")
            } else {
                print("✅ Xóa sản phẩm thành công!")
            }
        }
    }

    // Thêm sản phẩm vào Firestore
    func addProduct(_ product: Product, completion: @escaping () -> Void) {
        do {
            try db.collection("products").document(product.id).setData(from: product) { error in
                if let error = error {
                    print("❌ Lỗi khi thêm sản phẩm: \(error.localizedDescription)")
                } else {
                    print("✅ Thêm sản phẩm thành công!")
                    completion()
                }
            }
        } catch {
            print("❌ Lỗi khi encode sản phẩm: \(error.localizedDescription)")
        }
    }
}
