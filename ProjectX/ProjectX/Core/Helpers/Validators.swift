//
//  Validators.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 22.10.2022.
//

import Foundation

class Validators {
    
    static func isFilled(firstname: String?, lastName: String?, dateOfBirth: String?, email: String?, phoneNumber: String?, password: String?) -> Bool {
        guard !(firstname ?? "").isEmpty,
              !(lastName ?? "").isEmpty,
              !(dateOfBirth ?? "").isEmpty,
              !(email ?? "").isEmpty,
              !(phoneNumber ?? "").isEmpty,
              !(password ?? "").isEmpty else {
            return false
        }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    static func isSimplePhoneNomber(_ phoneNomber: String) -> Bool {
        if phoneNomber.count < 18 {
            return false } else {
                return true
            }
        }
    
    static func isSimplePassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{6,}$"
        return check(text: password, regEx: passwordRegEx)
    }
    
    static func isSimpleName(_ name: String) -> Bool {
        let nameRegEx = "^(?=.*[A-Za-z])[A-Za-z]{1,}$"
        return check(text: name, regEx: nameRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
