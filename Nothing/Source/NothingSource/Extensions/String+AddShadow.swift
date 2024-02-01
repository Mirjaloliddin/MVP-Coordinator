//
//  String+AddShadow.swift
//  CommetaID
//
//  Created by Khalmatov on 27.09.2023.
//

import UIKit

//import Lottie

extension UIView {
    func addShadow(offset: CGSize = CGSize(width: 3, height: 3), color: UIColor = .black, radius: CGFloat = 5, opacity: Float = 1) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    func addShadow2(offset: CGSize = CGSize(width: 3, height: 3), color: UIColor = .black, radius: CGFloat = 5, opacity: Float = 1) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}
