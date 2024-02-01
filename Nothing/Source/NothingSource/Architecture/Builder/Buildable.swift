//
//  Buildable.swift
//  Commeta
//
//  Created by Hasan on 05/07/23.
//  Copyright © 2023 imkon.uz. All rights reserved.
//

import Foundation

protocol Buildable {
    associatedtype InitialParams
    associatedtype ClassType

    static func build(with params: InitialParams) -> ClassType
}

protocol BuildableScene: Buildable where ClassType: Scene {

}

protocol BuildableCoordinator: Buildable where ClassType: Coordinator {

}

protocol BuildableRouter: Buildable where ClassType: Router {

}
