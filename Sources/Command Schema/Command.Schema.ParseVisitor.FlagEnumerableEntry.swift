internal import Index
internal import Ordinal
public import Tagged
internal import Text
internal import Environment


extension Command.Schema.ParseVisitor {
    @usableFromInline
    internal struct FlagEnumerableEntry: Sendable {

        @usableFromInline let casesByLongName: [String: @Sendable (inout Root) -> Void]
    }
}
