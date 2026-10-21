import Testing

@testable import Command_Test_Support

extension Git {
    @Suite
    struct `End of options before the subcommand` {

        @Test
        func `a bare -- before the subcommand ends options and still dispatches`() throws(Command.Error) {
            let parsed = try Command.parse(
                Git.self,
                from: ["--", "status", "--short"],
                initial: .status(.init())
            )
            #expect(parsed == .status(Status(short: true)))
        }

        @Test
        func `after -- a name that looks like an option is resolved as the subcommand`() {
            do throws(Command.Error) {
                _ = try Command.parse(Git.self, from: ["--", "--short"], initial: .status(.init()))
                Issue.record("Expected .unknownSubcommand, parse succeeded")
            } catch {
                switch error {
                case .unknownSubcommand:
                    break

                default:
                    Issue.record("Expected .unknownSubcommand, got \(error)")
                }
            }
        }
    }
}
