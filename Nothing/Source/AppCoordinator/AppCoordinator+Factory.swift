//
//  AppCoordinator+Factory.swift
//  Commeta
//
//  Created by Hasan on 06/07/23.
//

import Foundation

extension AppCoordinator {
    class Factory {
        init(/*Services and params of Flow*/) {

        }
    }
}

// MARK: - Scenes
extension AppCoordinator.Factory {
    func signInCoordinator(windowRouter: WindowRouter ,router: NavigableRouter, listener: SignInCoordinatorListener) -> Coordinator {
        let coordinator = Builder.Coordinator<SignInCoordinator>.make(with:
                .init(
                    router: router,
                    listener: listener)
        )
        coordinator.windowRouter = windowRouter
        return coordinator
    }
}

// MARK: - Coordinators
extension AppCoordinator.Factory {

}
