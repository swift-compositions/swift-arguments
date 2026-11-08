internal import Index
internal import Ordinal
public import Tagged
internal import Text
internal import Environment


extension Command.Schema.ParseVisitor {
    @usableFromInline
    internal struct SubcommandGroupEntry: Sendable {

        @usableFromInline let bindings: [any Command.Subcommand.Binding<Root>]
    }
}
