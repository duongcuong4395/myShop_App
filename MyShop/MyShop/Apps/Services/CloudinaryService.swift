//
//  CloudinaryService.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import Cloudinary
import SwiftUI

class CloudinaryService {
    static let shared = CloudinaryService()
    private let cloudinary: CLDCloudinary

    private init() {
        let config = CLDConfiguration(cloudName: "duongcuong", apiKey: "775165578994551", apiSecret: "wavEwy_Q63kFTcGxM_s-Gk7fx7o")
        cloudinary = CLDCloudinary(configuration: config)
    }

    func uploadImage(imageData: Data, completion: @escaping (String?) -> Void) {
        let uploader = cloudinary.createUploader()
        uploader.upload(data: imageData, uploadPreset: "MyShop_Preset", completionHandler:  { result, error in
            if let error = error {
                print("=== uploadImage.eror", error)
            }
            if let url = result?.secureUrl {
                completion(url)
            } else {
                completion(nil)
            }
        })
    }
}
