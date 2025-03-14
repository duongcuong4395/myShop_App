//
//  AdminAddProductView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI
import PhotosUI

import SwiftUI

struct AdminAddProductView: View {
    @StateObject private var viewModel = AdminAddProductViewModel()
    @State private var isPickerPresented = false
    @State private var isCameraSelected = false

    var body: some View {
        Form {
            Section(header: Text("Thông tin sản phẩm")) {
                TextField("Tên sản phẩm", text: $viewModel.name)
                TextField("Giá sản phẩm", text: $viewModel.price)
                    .keyboardType(.decimalPad)
                Picker("Loại sản phẩm", selection: $viewModel.category) {
                    ForEach(ProductCategory.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
            }

            Section(header: Text("Hình ảnh sản phẩm")) {
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                } else {
                    Button("Chọn ảnh") { isPickerPresented = true }
                }
            }

            Button(action: viewModel.uploadProduct) {
                HStack {
                    if viewModel.isUploading {
                        ProgressView()
                    }
                    Text("Lưu sản phẩm")
                }
            }
        }
        .navigationTitle("Thêm sản phẩm")
        .actionSheet(isPresented: $isPickerPresented) {
            ActionSheet(
                title: Text("Chọn nguồn ảnh"),
                buttons: [
                    .default(Text("Chụp ảnh")) {
                        isCameraSelected = true
                        isPickerPresented = true
                    },
                    .default(Text("Chọn từ thư viện")) {
                        isCameraSelected = false
                        isPickerPresented = true
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $isPickerPresented) {
            ImagePicker(selectedImage: $viewModel.selectedImage, sourceType: isCameraSelected ? .camera : .photoLibrary)
        }
    }
}



import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}
