//
//  AdminAddProductViewModel.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI

class AdminAddProductViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var category: ProductCategory = .food
    @Published var selectedImage: UIImage?
    @Published var isUploading = false

    private let service = ProductService()

    func uploadProduct(complete: @escaping (Bool) -> Void) {
        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.8) else {
            complete(false)
            return }
        isUploading = true

        CloudinaryService.shared.uploadImage(imageData: imageData) { [weak self] imageUrl in
            guard let imageUrl = imageUrl, let priceValue = Double(self?.price ?? "") else {
                complete(false)
                return }
            let newProduct = Product(id: UUID().uuidString, name: self?.name ?? "", price: priceValue, imageUrl: imageUrl, category: self?.category ?? .food)

            self?.service.addProduct(newProduct) {
                self?.isUploading = false
                complete(true)
            }
        }
    }
}
