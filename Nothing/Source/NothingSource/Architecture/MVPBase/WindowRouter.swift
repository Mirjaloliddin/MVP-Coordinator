import UIKit

protocol ReplacableView {
    func replaceRoot(with viewController: UIViewController, animated: Bool)
}

class WindowRouter: PresentableRouter, ReplacableRouter, ReplacableView {
    private let window: UIWindow

    var scene: Scene { fatalError("WindowRouter can't be a scene for present") }

    init(with window: UIWindow? = nil) {
        self.window = window ?? UIWindow()
    }

    func present(_ scene: Scene, animated: Bool, completion: RouterCompletion?) {
        self.window.rootViewController?.present(scene, animated: animated, completion: completion)
    }

    func dismiss(animated: Bool, completion: RouterCompletion?) {
        self.window.rootViewController?.dismiss(animated: animated, completion: completion)
    }

    func replace(with scene: Scene, animated: Bool = false) {
        self.window.rootViewController = scene

        if !self.window.isKeyWindow {
            self.window.makeKeyAndVisible()
        }
    }

    func replaceRoot(with viewController: UIViewController, animated: Bool = false) {
        self.window.rootViewController = viewController

        if !self.window.isKeyWindow {
            self.window.makeKeyAndVisible()
        }
    }

    func replaceStack(with scenes: [Scene], animated: Bool) {}
}

extension WindowRouter: Buildable {
    struct InitialParams {
        let window: UIWindow?
    }

    static func build(with params: InitialParams) -> WindowRouter {
        return .init(with: params.window)
    }
}
