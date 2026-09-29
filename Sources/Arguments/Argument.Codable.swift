public import Argument

extension Argument {

    public protocol Codable: Argument.Parseable, Argument.Serializable {}
}
