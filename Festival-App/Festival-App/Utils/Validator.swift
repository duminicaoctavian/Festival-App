//
//  Validator.swift
//  Festival-App
//
//  Created by Octavian Duminica on 04/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

enum InputError: Error {
    case invalidUsername
    case invalidEmail
    case invalidPasswordMatching
    case invalidPassword
}

class Validator {
    
    private static var isValid: Bool = true
    
    static func validateUsername(_ username: String) throws {
        isValid = username.count >= 6 ? true : false
        if !isValid {
            throw InputError.invalidUsername
        }
    }
    
    static func validateEmail(_ email: String) throws {
        let regex = Regex.email
        let predicate = NSPredicate(format: PredicateFormat.matches, regex)
        isValid = predicate.evaluate(with: email)
        if !isValid {
            throw InputError.invalidEmail
        }
    }
    
    static func validatePasswordMatching(password: String, confirmPassword: String) throws {
        isValid = password == confirmPassword && password.count >= 6
        if !isValid {
            throw InputError.invalidPasswordMatching
        }
    }
    
    static func validatePassword(_ password: String) throws {
        isValid = password.count >= 6
        if !isValid {
            throw InputError.invalidPassword
        }
    }
}

extension InputError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidEmail: return NSLocalizedString("Your email is invalid!", comment: "Invalid Email")
        case .invalidPassword: return NSLocalizedString("Your password must have at least 6 characters.", comment: "Invalid Password")
        case .invalidPasswordMatching: return NSLocalizedString("Your passwords must match and they must have at least 6 characters.", comment: "Password Mismatch")
        case .invalidUsername: return NSLocalizedString("Your username must have at least 6 alphanumeric characters.", comment: "Invalid Username")
        }
    }
}


private struct Regex {
    static let email = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
}

private struct PredicateFormat {
    static let matches = "SELF MATCHES %@"
}
