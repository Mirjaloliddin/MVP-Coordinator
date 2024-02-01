//
//  Builder.swift
//  Commeta
//
//  Created by Hasan on 05/07/23.
//  Copyright © 2023 imkon.uz. All rights reserved.
//

// swiftlint:disable force_cast

struct Builder {
    private init() {}
}

extension Builder {
    struct Scene<T: BuildableScene> {
        static func make(with params: T.InitialParams) -> T {
            return T.build(with: params) as! T
        }
    }
}

extension Builder {
    struct Coordinator<T: BuildableCoordinator> {
        static func make(with params: T.InitialParams) -> T {
            return T.build(with: params) as! T
        }
    }
}

extension Builder {
    struct Router<T: BuildableRouter> {
        static func make(with params: T.InitialParams) -> T {
            return T.build(with: params) as! T
        }
    }
}
// swiftlint:enable force_cast
