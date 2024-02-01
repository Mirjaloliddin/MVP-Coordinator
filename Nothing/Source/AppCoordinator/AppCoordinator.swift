//
//  AppCoordinator.swift
//  Commeta
//
//  Created by Hasan on 06/07/23.
//

import UIKit

protocol AppCoordinatorListener: CoordinatorListener {
    func handle(_ coordinator: AppCoordinator, event: AppCoordinator.Event)
}

typealias AppCoordinatorRouter = WindowRouter

final class AppCoordinator: BaseCoordinator<AppCoordinatorRouter, AppCoordinatorListener> {
    private let factory: AppCoordinator.Factory

    override init(_ router: AppCoordinatorRouter, listener: AppCoordinatorListener? = nil) {
        self.factory = Factory()
        super.init(router, listener: listener)
    }

    override func start() {
        let coordinator = performSignInCoordinator()
        coordinator.start()
    }

    private func performOnboardingScene() {
    }
    
    private func performSignInCoordinator() -> Coordinator {
        let navigationRouter = NavigationRouter()
        let coordinator = factory.signInCoordinator(windowRouter: router ,router: navigationRouter, listener: self)
        store(coordinator)
        return coordinator
    }

}

extension AppCoordinator {
    enum Event {
    }
}

extension AppCoordinator: BuildableCoordinator {
    struct InitialParams {
        let router: AppCoordinatorRouter
        let listener: AppCoordinatorListener?
    }

    static func build(with params: InitialParams) -> AppCoordinator {
        return .init(params.router, listener: params.listener)
    }
}

extension AppCoordinator: SignInCoordinatorListener {
    func handle(_ coordinator: SignInCoordinator, event: SignInCoordinator.Event) {
        
    }
}
