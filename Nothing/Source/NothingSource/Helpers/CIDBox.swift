//
//  Box.swift
//  CommetaID
//
//  Created by Khalmatov on 26.09.2023.
//

import Foundation

final class CIDBox<T> {
    
    typealias Listener = (T) -> Void
  
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
    
  
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
