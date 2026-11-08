internal import Index
internal import Ordinal
public import Tagged
internal import Text
internal import Environment


extension Command.Schema.ParseVisitor {
    @usableFromInline
    internal struct PositionalEntry: Sendable {

        @usableFromInline let name: String

        @usableFromInline let apply: @Sendable (String, inout Root) -> Bool
    }
}
