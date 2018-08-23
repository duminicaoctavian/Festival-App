//
//  NotificationService.swift
//  Festival-App
//
//  Created by Octavian Duminica on 23/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import UserNotifications

private struct Log {
    static let noAuthorizationError = "No UserNotification authorization error"
    static let didReceiveDelegateMethod = "didReceive"
    static let willPresentDelegateMethod = "willPresent"
}

class NotificationService: NSObject {
    
    private override init() {}
    static let shared = NotificationService()
    
    let UNCenter = UNUserNotificationCenter.current()
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? Log.noAuthorizationError)
            
            guard granted else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.configure()
            }
        }
    }
    
    func configure() {
        UNCenter.delegate = self
        
        let application = UIApplication.shared
        application.registerForRemoteNotifications()
    }
}

extension NotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print(Log.didReceiveDelegateMethod)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(Log.willPresentDelegateMethod)
        completionHandler([.alert, .badge, .sound])
    }
}
