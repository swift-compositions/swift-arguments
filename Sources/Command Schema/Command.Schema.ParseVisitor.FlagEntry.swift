internal import Index
internal import Ordinal
public import Tagged
internal import Text
internal import Environment


extension Command.Schema.ParseVisitor {
    @usableFromInline
    internal struct FlagEntry: Sendable {

        @usableFromInline let name: Argument.Name

        @usableFromInline let apply: @Sendable (inout Root) -> Void
    }
}
