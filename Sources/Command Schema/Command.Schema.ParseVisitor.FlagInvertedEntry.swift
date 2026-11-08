internal import Index
internal import Ordinal
public import Tagged
internal import Text
internal import Environment


extension Command.Schema.ParseVisitor {
    @usableFromInline
    internal struct FlagInvertedEntry: Sendable {

        @usableFromInline let trueName: String

        @usableFromInline let falseName: String

        @usableFromInline let apply: @Sendable (Bool, inout Root) -> Void
    }
}
