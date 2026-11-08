internal import Index
internal import Ordinal
public import Tagged
internal import Text
internal import Environment


extension Command.Schema.ParseVisitor {
    @usableFromInline
    internal struct OptionEntry: Sendable {

        @usableFromInline let name: Argument.Name

        @usableFromInline let apply: @Sendable (String, inout Root) -> Bool

        @usableFromInline let environment: Argument.Environment.Variable.Name?
    }
}
