//
//  StorageService.swift
//  Festival-App
//
//  Created by Octavian Duminica on 07/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import AWSS3
import AWSCognito

private struct Constants {
    static let awsKey = "eu-central-1:63c762b5-ff45-4253-937b-dd9f1a822a3b"
    static let bucketName = "octaviansuniversalbucket"
}

class StorageService {
    static let shared = StorageService()

    func setupProvider() {
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.EUCentral1, identityPoolId: Constants.awsKey)
        let configuration = AWSServiceConfiguration(region:.EUCentral1, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }

    func uploadFile(imageName: String, withData imageData: Data, completion: @escaping CompletionHandler) {
        
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        fileManager.createFile(atPath: path as String, contents: imageData, attributes: nil)
        
        let localImageUrl = URL(fileURLWithPath: path)
        let key = imageName
        
        guard let request = AWSS3TransferManagerUploadRequest() else { completion(false); return }
        request.bucket = Constants.bucketName
        request.key = key
        request.body = localImageUrl
        request.acl = .publicReadWrite
        
        let transferManager = AWSS3TransferManager.default()
        transferManager.upload(request).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any? in
            if let error = task.error {
                debugPrint(error as Any)
                completion(false)
                return nil
            }
            
            if task.result != nil {
                completion(true)
            }
            return nil
        }
    }
}
