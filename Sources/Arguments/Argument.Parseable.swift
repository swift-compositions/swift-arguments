public import Argument

extension Argument {

    public protocol Parseable: Sendable {

        init?(argument: String)
    }
}
