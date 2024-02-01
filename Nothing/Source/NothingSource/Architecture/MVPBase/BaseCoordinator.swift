//
//  BaseCoordinator.swift
//  Commeta
//
//  Created by Hasan on 05/07/23.
//  Copyright © 2023 imkon.uz. All rights reserved.
//

import Foundation

class StoredCoordinator: Coordinator {
    private weak var parent: Coordinator?
    private var children = [ObjectIdentifier: Coordinator]()

    func start() {
        // override
    }

    func finish() {
        parent?.free(self)
    }

    func store(_ coordinator: Coordinator) {
        guard let coordinator = coordinator as? StoredCoordinator else {
            fatalError("BaseCoordinator: can't store child coordinator")
        }
        children[ObjectIdentifier(coordinator)] = coordinator
        coordinator.parent = self
    }

    func free(_ coordinator: Coordinator) {
        guard let coordinator = coordinator as? StoredCoordinator else {
            fatalError("BaseCoordinator: can't free child coordinator")
        }
        children.removeValue(forKey: ObjectIdentifier(coordinator))
        coordinator.parent = nil
    }
}

class BaseCoordinator<R, L>: StoredCoordinator {
    let router: R
    var listener: L? { _listener as? L }

    private weak var _listener: CoordinatorListener?

    init(_ router: R, listener: L? = nil) {
        _ = ConfirmationWrapper<R, Router>(router).wrappedValue
        _listener = ConfirmationWrapper<L, CoordinatorListener>(listener)?.wrappedValue
        self.router = router
    }
}
