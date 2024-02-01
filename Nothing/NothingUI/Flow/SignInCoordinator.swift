//
//  SignInCoordinator.swift
//  CommetaID
//
//  Created by  Abdurahmon on 14/09/23.
//

import UIKit

protocol SignInCoordinatorListener: CoordinatorListener {
    func handle(_ coordinator: SignInCoordinator, event: SignInCoordinator.Event)
}

typealias SignInCoordinatorRouter = NavigableRouter

final class SignInCoordinator: BaseCoordinator<SignInCoordinatorRouter, SignInCoordinatorListener> {
    private let factory: SignInCoordinator.Factory
    var windowRouter: WindowRouter!
    
    override init(_ router: SignInCoordinatorRouter, listener: SignInCoordinatorListener? = nil) {
        self.factory = Factory()
        super.init(router, listener: listener)
    }
    
    override func start() {
       let scene = performMainScene()
        router.replaceStack(with: [scene], animated: false)
        windowRouter.replaceRoot(with: router.scene)
    }
    
    private func performMainScene() -> Scene {
        let scene = factory.pincodeScene(listener: self)
        return scene
    }
    
    private func performWelcome() {
        let scene = factory.welcomeScene(listener: self)
        router.push(scene)
    }

}

extension SignInCoordinator {
    enum Event {
        case finished
        //Add Coordinator events
    }
}

extension SignInCoordinator: SetPinCodePresenterListener {
    func handle(_ presenter: SetPinCodePresenter, event: SetPinCodePresenter.Event) {
        switch event {
        case .goToNext:
            performWelcome()
        }
    }
}

extension SignInCoordinator: WelcomePresenterListener {
    func handle(_ presenter: WelcomePresenter, event: WelcomePresenter.Event) {
        
    }
}

extension SignInCoordinator: BuildableCoordinator {
    struct InitialParams {
        let router: SignInCoordinatorRouter
        let listener: SignInCoordinatorListener?
    }
    
    static func build(with params: InitialParams) -> SignInCoordinator {
        return .init(params.router, listener: params.listener)
    }
}
