import Foundation

public protocol Presentable: AnyObject {
    var scene: Scene { get }
}

public extension Presentable where Self: Scene {
    var scene: Scene { self }
}
