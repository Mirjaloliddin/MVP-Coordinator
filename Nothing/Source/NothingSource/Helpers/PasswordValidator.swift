//
//  PasswordValidator.swift
//  CommetaID
//
//  Created by Khalmatov on 06.10.2023.
//

import Foundation
class PasswordValidator {
    
    static let shared = PasswordValidator()
    
    func checkIsFilled(text: String) -> Bool {
        return text.count >= 6
    }
    
    func atLeastOneDigit(text: String) -> Bool {
        guard NSPredicate(format:"SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: text) else {
          return false
        }
        return true
    }
    
    func atLeastOneUppercase(text: String) -> Bool {
        guard NSPredicate(format:"SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: text) else {
            return false
        }
        return true
    }
    
    func atLeastOneSymbol(text: String) -> Bool {
        guard NSPredicate(format:"SELF MATCHES %@", ".*[!&^%$#@()/]+.*").evaluate(with: text) else  {
            return false
     }
        return true
    }
    
    func atLeastOneLowercase(text: String) -> Bool {
        guard NSPredicate(format:"SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: text) else {
            return false
        }
        return true
    
    }
}
