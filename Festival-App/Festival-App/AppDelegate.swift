//
//  AppDelegate.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit
import CoreData
import Firebase

// for SQ

private struct Log {
    static let didRegisterForNotifications = "didRegisterForNotifications"
    static let didFailToRegisterForNotifications = "didFailToRegisterToNotifications"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.isStatusBarHidden = false
        
        FirebaseApp.configure()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        UIApplication.shared.statusBarStyle = .lightContent
        
        if AuthService.shared.isServerless {
            if FirebaseAuthService.shared.isLoggedIn {
                let rootController = storyboard.instantiateViewController(withIdentifier: StoryboardID.SWRevealViewController)
                if let window = self.window {
                    window.rootViewController = rootController
                }
            } else {
                let rootController = storyboard.instantiateViewController(withIdentifier: StoryboardID.loginViewController)
                if let window = self.window {
                    window.rootViewController = rootController
                }
            }
        } else {
            if AuthService.shared.isLoggedIn {
                let rootController = storyboard.instantiateViewController(withIdentifier: StoryboardID.SWRevealViewController)
                if let window = self.window {
                    window.rootViewController = rootController
                }
            } else {
                let rootController = storyboard.instantiateViewController(withIdentifier: StoryboardID.loginViewController)
                if let window = self.window {
                    window.rootViewController = rootController
                }
            }
        }
        
        NotificationService.shared.authorize()
        
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        SocketService.shared.establishConnection()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        SocketService.shared.closeConnection()
        self.saveContext()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        AuthService.shared.deviceToken = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print(AuthService.shared.deviceToken!)
        print(Log.didRegisterForNotifications)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(Log.didFailToRegisterForNotifications)
        
        print(error)
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Festival_App")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
