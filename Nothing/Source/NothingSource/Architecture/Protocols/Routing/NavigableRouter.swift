import Foundation

protocol NavigableRouter: Router, PresentableRouter {
    func push(_ scene: Scene, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func replaceStack(with scenes: [Scene], animated: Bool)
    func storeScene()
    func restoreScene()
}

extension NavigableRouter {
    func push(_ scene: Scene) {
        push(scene, animated: true)
    }

    func pop() {
        pop(animated: true)
    }

    func popToRoot() {
        popToRoot(animated: true)
    }

    func storeScene() { }

    func restoreScene() { }
}
