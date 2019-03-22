//
//  FirebaseAuthService.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/09/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FirebaseAuthService {
    static let shared = FirebaseAuthService()
    
    let defaults = UserDefaults.standard

    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: UserDefaultsKey.loggedIn)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKey.loggedIn)
        }
    }

    var user: User {
        get {
            return getUserFromDefaults() ?? User()
        }
        set {
            saveUserToDefauls(user: newValue)
        }
    }

    var deviceToken: String?

    private func getUserFromDefaults() -> User? {
        if let data = UserDefaults.standard.data(forKey: UserDefaultsKey.user) {
            if let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? User {
                return user
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    private func saveUserToDefauls(user: User) {
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(data, forKey: UserDefaultsKey.user)
    }

    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (_, error) in
            guard let weakSelf = self else { completion(false); return }
            
            if error != nil {
                print(error as Any)
                completion(false)
                return
            }
            
            weakSelf.fetchUserFromDatabase(completion: { [weak self] (success) in
                guard let weakSelf = self else { completion(false); return }
                if success {
                    weakSelf.isLoggedIn = true
                    completion(true)
                } else {
                    weakSelf.isLoggedIn = false
                    completion(false)
                }
            })
        }
    }
    
    func fetchUserFromDatabase(completion: @escaping CompletionHandler) {
        guard let uid = Auth.auth().currentUser?.uid else { completion(false); return }
        Database.database().reference().child(FirebaseChild.users).child(uid).observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            guard let weakSelf = self else { completion(false); return }
            
            if var dictionary = snapshot.value as? [String: AnyObject] {
                let key = snapshot.key
                dictionary.updateValue(key as AnyObject, forKey: "_id")
                if let user = User(dictionary: dictionary) {
                    weakSelf.saveUserToDefauls(user: user)
                    completion(true)
                } else {
                    completion(false)
                    return
                }
            } else {
                completion(false)
                return
            }
        }, withCancel: nil)
    }
    
    func registerUser(username: String, email: String, password: String, completion: @escaping CompletionHandler) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            guard let weakSelf = self else { completion(false); return }
            
            if error != nil {
                print(error as Any)
                completion(false)
                return
            }
            
            guard let uid = user?.user.uid else {
                completion(false)
                return
            }
            
            let values = User.generateFirebaseRegisterBody(username: username, email: email)
            
            weakSelf.addUserToDatabase(withUID: uid, values: values as [String : AnyObject], completion: { [weak self] (success) in
                guard let weakSelf = self else { completion(false); return }
                if success {
                    weakSelf.fetchUserFromDatabase(completion: { [weak self] (success) in
                        guard let weakSelf = self else { completion(false); return }
                        if success {
                            weakSelf.isLoggedIn = true
                            completion(true)
                        } else {
                            weakSelf.isLoggedIn = false
                            completion(false)
                        }
                    })
                } else {
                    completion(false)
                }
            })
        }
    }
    
    func addUserToDatabase(withUID uid: String, values: [String: AnyObject], completion: @escaping CompletionHandler) {
        
        let usersReference = Database.database().reference().child(FirebaseChild.users).child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (error, _) in
            
            if error != nil {
                print(error as Any)
                completion(false)
                return
            }
            
            completion(true)
        })
    }

    func logoutUser(completion: @escaping CompletionHandler) {
        do {
            guard Auth.auth().currentUser?.uid != nil else { completion(false); return }
            
            try Auth.auth().signOut()

            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: UserDefaultsKey.user)
            
            isLoggedIn = false

            completion(true)
        } catch let error {
            print(error)
            completion(false)
            return
        }
    }
}
