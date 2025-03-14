//
//  AdminAddProductView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI
import PhotosUI

struct AdminAddProductView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var productCategoryVM: ProductCategoryViewModel
    @EnvironmentObject var productListVM: ProductListViewModel
    
    @StateObject private var adminAddProductVM = AdminAddProductViewModel()
    @State private var isPickerPresented = false
    @State private var isCameraSelected = false
    @State private var isphotoLibrarySelected = false

    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                ScrollView(showsIndicators: false) {
                    SelectCategoryView(currentCategory: adminAddProductVM.category) { category in
                        withAnimation {
                            adminAddProductVM.category = category
                        }
                    }
                    
                    SelectImageProductView(imageSelected: adminAddProductVM.selectedImage
                                           , ontabSelectImage: {
                        isPickerPresented = true
                    })
                    
                    .overlay {
                        if let selectedImage = adminAddProductVM.selectedImage {
                            VStack {
                                Spacer()
                                VStack(spacing: 10){
                                    HStack(spacing: 0) {
                                        Text("Tên:")
                                            .font(.body)
                                        TextField("........................", text: $adminAddProductVM.name)
                                            .textFieldMaxLength(value: $adminAddProductVM.name, maxLength: 50)
                                            .padding(.vertical, 5)
                                    }
                                    HStack(spacing: 0) {
                                        Text("Giá:")
                                            .font(.body)
                                        Text(adminAddProductVM.price.isEmpty ? "........................" : adminAddProductVM.price.formattedCurrency())
                                            .foregroundColor(adminAddProductVM.price.isEmpty ? .gray : .black)
                                        
                                        Text (" VND")
                                            .font(.body.bold())
                                        Spacer()
                                    }
                                    .onTapGesture {
                                        isFocused = true
                                    }
                                    TextField("", text: $adminAddProductVM.price)
                                        .keyboardType(.numberPad)
                                        .focused($isFocused)
                                        .textFieldMaxLength(value: $adminAddProductVM.price, maxLength: 9)
                                        .opacity(0) // Ẩn TextField nhưng vẫn nhận input
                                }
                                .padding(5)
                                .background(.ultraThinMaterial.opacity(0.9), in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                            }
                        }
                    }
                    
                }
                
            }
            .padding(.horizontal, 5)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .foregroundStyle(.black)
                                .fontWeight(.bold)
                        })
                        Text("Thêm sản phẩm")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        adminAddProductVM.uploadProduct { isSuccess in
                            productListVM.loadProducts(for: productCategoryVM.categorySelected)
                            dismiss()
                        }
                    }, label: {
                        HStack {
                            if adminAddProductVM.isUploading {
                                ProgressView()
                            }
                            Text("Lưu")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(width: 80, height: 35)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        
                    })
                    .disabled(adminAddProductVM.isUploading)
                }
            }
        }
        .actionSheet(isPresented: $isPickerPresented) {
            ActionSheet(
                title: Text("Chọn nguồn ảnh"),
                buttons: [
                    .default(Text("Chụp ảnh")) {
                        checkCameraPermission{ granted in
                            if granted {
                                isCameraSelected = true
                            } else {
                                print("Camera access denied!")
                            }
                        }
                    },
                    .default(Text("Chọn từ thư viện")) {
                        isphotoLibrarySelected = true
                       
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $isphotoLibrarySelected) {
            ImagePicker(selectedImage: $adminAddProductVM.selectedImage, sourceType: .photoLibrary)
        }
        
        .sheet(isPresented: $isCameraSelected) {
            ImagePicker(selectedImage: $adminAddProductVM.selectedImage, sourceType: .camera)
        }
        
        .onTapGesture {
            hideKeyboard()
        }
    }
}



struct SelectImageProductView: View {
    var imageSelected: UIImage?
    var ontabSelectImage: () -> Void
    
    var body: some View {
        if let image = imageSelected {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .clipShape(.rect(cornerRadius: 15))
                //.frame(height: 400)
        } else {
            Image(systemName: "camera")
                .font(.title)
                .padding()
                .background(.ultraThinMaterial, in: Circle())
                .onTapGesture {
                    ontabSelectImage()
                }
                .padding()
        }
    }
}

struct SelectCategoryView: View {
    var currentCategory: ProductCategory
    
    var onTabCategory: (ProductCategory) -> Void
    
    var body: some View {
        HStack {
            ForEach(ProductCategory.allCases) { category in
                if category != .all {
                    VStack {
                        Image(category.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 50 : 100, height: UIDevice.current.userInterfaceIdiom == .phone ? 50 : 100)
                            .clipShape(.rect(cornerRadius: 8))
                        Text(category.rawValue)
                            .font(.callout)
                            .foregroundStyle(currentCategory == category ? .white : Color.primary)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.background)
                                .opacity(!(currentCategory == category) ? 1 : 0)
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.green.gradient)
                                .opacity(currentCategory == category ? 1 : 0)
                        }
                    }
                    .onTapGesture {
                        onTabCategory(category)
                    }
                    
                }
            }
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


import AVFoundation

func checkCameraPermission(completion: @escaping (Bool) -> Void) {
    let status = AVCaptureDevice.authorizationStatus(for: .video)
    switch status {
    case .authorized:
        completion(true)  // Quyền đã cấp, mở camera
    case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                completion(granted) // Nếu được cấp quyền, mở camera
            }
        }
    default:
        completion(false)  // Quyền bị từ chối hoặc hạn chế
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}





struct TextFieldMaxLengthModifier: ViewModifier {
    @Binding var value: String
    var maxLength: Int
    
    func body(content: Content) -> some View {
        content
            .onChange(of: value) { oldValue, newValue in
                if value.count > maxLength {
                    value = String(value.prefix(maxLength))
                }
            }
    }
}






extension View {
    
    func textFieldMaxLength(value: Binding<String>, maxLength: Int) -> some View {
        self.modifier(TextFieldMaxLengthModifier(value: value, maxLength: maxLength))
    }
}



extension Int {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "." // Dấu phân cách hàng nghìn
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

extension String {
    func formattedCurrency() -> String {
        // Loại bỏ tất cả ký tự không phải số
        let filtered = self.filter { $0.isNumber }
        
        // Chuyển về Int để định dạng
        if let number = Int(filtered) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = "." // Dấu phân cách hàng nghìn
            return formatter.string(from: NSNumber(value: number)) ?? self
        }
        
        return self
    }
}
