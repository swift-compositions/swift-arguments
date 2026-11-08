internal import Index
internal import Ordinal
public import Tagged
internal import Text
internal import Environment


extension Command.Schema.ParseVisitor {
    @usableFromInline
    internal struct PositionalManyEntry: Sendable {

        @usableFromInline let name: String

        @usableFromInline let arity: Argument.Arity

        @usableFromInline let append: @Sendable (String, inout Root) -> Bool

        @usableFromInline let count: @Sendable (Root) -> Int
    }
}
