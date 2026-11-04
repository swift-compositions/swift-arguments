# swift-arguments

Use this package when you write a command-line tool and want argv parsed into a struct you own, with help text generated from the same declaration. Conform your command to `Command.Protocol`, declare its arguments once in a `Command.Schema.Definition`, and start it with `Command.main(_:initial:arguments:)`, or call `Command.parse(_:from:initial:)` to parse without running. Subcommands are cases of a `Command.Subcommand.Group`, and options shared by several commands go in a `Command.OptionGroup`. If you only need the argument vocabulary, such as names, arity and tokens, use swift-argument.

## Laws

- Parsing starts from the `initial` value you pass. Anything argv doesn't mention keeps its initial value. `Command.Protocol.validate()` runs after parsing, so it sees the final values.
- `--name value` and `--name=value` are the same. A value option takes the next argument whatever it is, unless that argument is another option. After `--`, every argument is positional.
- `-fvalue` gives the value to `-f` only if `-f` takes a value. Otherwise the letters are a cluster of flags, so `-vvv` counts three. A cluster can only hold flags and counted flags.
- An argument like `-5` or `-3.14` is a positional value when a positional is still open and no short option is named after that digit.
- Repeating a single option keeps the last value. For inverted and enumerable flags the last occurrence wins. Many options and many positionals append in argv order.
- Fixed positionals are filled first, in declaration order, and the rest go to the one many positional. A schema with two many positionals, including through option groups, fails to parse. Arity of many options and positionals is checked after parsing and fails validation if not met.
- A value that fails conversion or a transform fails as an invalid value. The transform's own error is dropped.
- An option with an environment variable reads it only when argv doesn't give the option. A value from the environment that fails conversion fails as an invalid environment value. This also works inside option groups.
- `--help` and `-h` request help unless the schema declares an option with that name. `--version` requests the version only when the configuration's version is non-empty. Otherwise it is an unknown option.
- An unknown long option or subcommand carries a suggestion: the closest declared name within an edit distance of the larger of 2 and a third of its length. Otherwise the suggestion is nil.
- A schema with a `Command.Subcommand.Group` may declare nothing else at the root, and fails to parse if it does, even when argv doesn't use it. A `Command.OptionGroup` can't contain a subcommand group. Two default cases in one group trap when the group is created.
- The first non-option argument names the subcommand, by name or alias, and the remaining arguments are parsed by that subcommand. `--` before the name lets a name that looks like an option be a subcommand. With no name, the default case is parsed from an empty argv, or parsing fails listing the available names. `--help` after the subcommand renders that subcommand's help titled with both names.
- Help leaves out hidden arguments and every argument of a hidden option group, and always lists `-h, --help`. A default is shown only when you render help with an initial value, and not for a `Bool`, an `Int` of zero, an empty collection or nil. A default written in the help wins.
- `Command.main(_:initial:arguments:)` reads `CommandLine.arguments` without the executable when you pass no arguments. It prints help, versions and diagnostics to standard output. It exits 0 for help and version, 64 for syntax and validation errors, 1 for wrapped argument errors, and the carried code for `Command.Error.exit(code:message:)` thrown while parsing. Any error thrown from `run()` exits 1, including `Command.Error.exit(code:message:)`.
