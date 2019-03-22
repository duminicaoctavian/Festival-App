//
//  UploadImageOperation.swift
//  Festival-App
//
//  Created by Octavian Duminica on 22/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class UploadImageOperation: AbstractOperation {
    
    let imageName: String
    let imageData: Data
    var onDidUpload: (() -> Void)!
    
    init(imageName: String, imageData: Data) {
        self.imageName = imageName
        self.imageData = imageData
    }
    
    override func execute() {
        uploadImage()
    }
    
    private func uploadImage() {
        StorageService.shared.uploadFile(imageName: imageName, withData: imageData) { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                weakSelf.onDidUpload()
                weakSelf.finished(error: nil)
            }
        }
    }
}
