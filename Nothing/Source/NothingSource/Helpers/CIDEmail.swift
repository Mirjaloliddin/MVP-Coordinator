//
//  EmailValidation.swift
//  CommetaID
//
//  Created by Khalmatov on 27.09.2023.
//

import Foundation

struct CIDEmail {
    
    static let shared = CIDEmail()
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

