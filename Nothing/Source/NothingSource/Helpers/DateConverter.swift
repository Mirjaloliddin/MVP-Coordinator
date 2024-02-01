//
//  DateConverter.swift
//  CommetaID
//
//  Created by Khalmatov on 12.10.2023.
//

import Foundation

class DateConverter {
    static let shared = DateConverter()
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
}
