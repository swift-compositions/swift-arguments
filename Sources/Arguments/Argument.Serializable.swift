public import Argument

extension Argument {

    public protocol Serializable: Sendable {

        var argumentDescription: String { get }
    }
}
