//
//  Vibration.swift
//  CommetaID
//
//  Created by Khalmatov on 27.09.2023.
//

import UIKit

enum CIDVibration {
    case warning
    case success
    
    public func vibrate() {
        switch self {
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }
}
