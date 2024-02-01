import Foundation

protocol Coordinator: AnyObject {
    func start()
    func finish()

    func store(_ coordinator: Coordinator)
    func free(_ coordinator: Coordinator)
}

protocol CoordinatorListener: Listener {

}
