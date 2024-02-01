//
//  NavigationRouter.swift
//  Commeta
//
//  Created by Hasan on 06/07/23.
//

import UIKit

class NavigationRouter: ReplacableRouter, NavigableRouter, PresentableRouter {
    private let navigationController: UINavigationController

    var scene: Scene { navigationController }

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    convenience init(_ navigationController: UINavigationController? = nil) {
        let controller = navigationController ?? UINavigationController()
        self.init(controller)
    }

    func replaceStack(with scenes: [Scene], animated: Bool) {
        navigationController.setViewControllers(scenes, animated: animated)
    }

    func push(_ scene: Scene, animated: Bool) {
        navigationController.pushViewController(scene, animated: animated)
    }

    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }

    func present(_ scene: Scene, animated: Bool, completion: RouterCompletion?) {
        navigationController.present(scene, animated: animated, completion: completion)
    }

    func dismiss(animated: Bool, completion: RouterCompletion?) {
        navigationController.dismiss(animated: animated, completion: completion)
    }

    func setViewControllers(controllers: [UIViewController], animated: Bool) {
        navigationController.setViewControllers(controllers, animated: animated)
    }
}

extension UINavigationController: Scene { }

extension NavigationRouter: BuildableRouter {
    struct InitialParams {
        let navigationController: UINavigationController?
    }

    static func build(with params: InitialParams) -> NavigationRouter {
        return .init(params.navigationController)
    }
}
