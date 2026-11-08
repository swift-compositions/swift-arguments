internal import Index
internal import Ordinal
public import Tagged
internal import Text
internal import Environment


extension Command.Schema.ParseVisitor {
    @usableFromInline
    internal struct FlagCountEntry: Sendable {

        @usableFromInline let name: Argument.Name

        @usableFromInline let increment: @Sendable (inout Root) -> Void
    }
}
