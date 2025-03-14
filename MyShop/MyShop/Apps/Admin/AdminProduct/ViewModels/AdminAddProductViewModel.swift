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
    //private let cloudinaryService = CloudinaryService()

    func uploadProduct() {
        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.8) else { return }
        isUploading = true

        CloudinaryService.shared.uploadImage(imageData: imageData) { [weak self] imageUrl in
            guard let imageUrl = imageUrl, let priceValue = Double(self?.price ?? "") else { return }
            let newProduct = Product(id: UUID().uuidString, name: self?.name ?? "", price: priceValue, imageUrl: imageUrl, category: self?.category ?? .food)

            self?.service.addProduct(newProduct) {
                self?.isUploading = false
            }
        }
    }
}
