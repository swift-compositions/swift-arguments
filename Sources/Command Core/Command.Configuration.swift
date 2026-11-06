extension Command {

    public struct Configuration: Sendable, Hashable, Equatable {

        public let name: String

        public let abstract: String

        public let discussion: String

        // swift-linter:disable:next raw concept
        // REASON: the text --version prints, as the program's author writes it, empty when the command has none; looked at Version.Semantic and Version.Tools, which refuse the empty default and tags such as 6.4-dev.
        public let version: String

        public let aliases: [String]

        @inlinable
        public init(
            name: String,
            abstract: String = "",
            discussion: String = "",
            // swift-linter:disable:next raw concept
            // REASON: the text --version prints, as the program's author writes it, empty when the command has none; looked at Version.Semantic and Version.Tools, which refuse the empty default and tags such as 6.4-dev.
            version: String = "",
            aliases: [String] = []
        ) {
            self.name = name
            self.abstract = abstract
            self.discussion = discussion
            self.version = version
            self.aliases = aliases
        }
    }
}
