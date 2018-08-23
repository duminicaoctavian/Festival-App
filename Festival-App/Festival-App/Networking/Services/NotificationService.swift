//
//  NotificationService.swift
//  Festival-App
//
//  Created by Octavian Duminica on 23/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationService: NSObject {
    
    private override init() {}
    static let shared = NotificationService()
    
    let unCenter = UNUserNotificationCenter.current()
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "No UserNotification authorization error")
            
            guard granted else { return }
            
            DispatchQueue.main.async {
                self.configure()
            }
        }
    }
    
    func configure() {
        unCenter.delegate = self
        
        let application = UIApplication.shared
        application.registerForRemoteNotifications()
    }
}

extension NotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("UserNotification didReceive")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("UserNotification willPresent")
        completionHandler([.alert, .badge, .sound])
    }
}
