//
//  AppLaunchComposer.swift
//  Commeta
//
//  Created by Hasan on 06/07/23.
//

import UIKit

final class AppComposer {
    private var windowRouter: WindowRouter!
    private var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func compose() -> AppLaunchManager {
        windowRouter = WindowRouter(with: window)

        let navigationRouter = NavigationRouter()
        windowRouter.replace(with: navigationRouter.scene)
        
        let coordinator = performAppCoordinator(router: windowRouter, listener: self)
        return AppLaunchManager(coordinator: coordinator)
    }

    // MARK: - Helper
    
    func performAppCoordinator(router: WindowRouter, listener: AppCoordinatorListener) -> AppCoordinator {
        let coordinator = Builder.Coordinator<AppCoordinator>
            .make(with: .init(router: router, listener: listener))
        StoredCoordinator().store(coordinator)
        return coordinator
    }
    
    
    func performSignInCoordinator(router: NavigableRouter, listener: SignInCoordinatorListener) {
        let coordinator = Builder.Coordinator<SignInCoordinator>
            .make(with: .init(router: router, listener: listener))
        coordinator.windowRouter = windowRouter
        StoredCoordinator().store(coordinator)
    }
    
    deinit {
        print("AppComposer deinitialized")
    }
}

extension AppComposer: AppCoordinatorListener {
    func handle(_ coordinator: AppCoordinator, event: AppCoordinator.Event) {
        let navigationRouter = NavigationRouter()
        performSignInCoordinator(router: navigationRouter, listener: self)
    }
}

extension AppComposer: SignInCoordinatorListener {
    func handle(_ coordinator: SignInCoordinator, event: SignInCoordinator.Event) {
        
    }
}
