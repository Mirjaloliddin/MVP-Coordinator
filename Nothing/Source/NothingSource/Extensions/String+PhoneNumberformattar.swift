//
//  Ex+String.swift
//  CommetaID
//
//  Created by Khalmatov on 25.09.2023.
//

import UIKit

extension String {
    
    // mask example: +XXX (XX) XXX-XXXX
    mutating func formatter(with mask: String, phone: String) {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        self = result
    }
    
    func getNotSpaceText()-> String {
       return self.components(separatedBy:.whitespacesAndNewlines).filter { $0.count > 0 }.joined(separator: " ")
   }
    
//    var localized: String {
//      return NSLocalizedString(self, tableName: nil, bundle: LocalizationManager.shared.currentLocalizationBundle, value: "", comment: "")
//    }

   
    func getDateFromString()-> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let date = formatter.date(from: self) {
           return date
        }
        return nil
    }
    
    public func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
    }

    
}

