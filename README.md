# swift-logic

Use this package when a condition can be true, false or not yet known, and the unknown case must carry through the computation instead of being forced to a Boolean early. Start from `Logic.Ternary`, whose operations work on `Bool?` (with `nil` as unknown) and on any type conforming to `Logic.Ternary.Protocol`; the builders `Logic.Ternary.Builder<T>.All`, `Logic.Ternary.Builder<T>.Any` and `Logic.Ternary.Builder<T>.None` fold a block of conditions into one. When every value is always known, use `Bool`. When the condition is a reusable test over values, use swift-predicate, which evaluates to this package's ternary values when the input is missing.

## Laws

- A conforming type must make `from(_:)` return `true`, `false` and `nil` for its `true`, `false` and `unknown`, and `init(_:)` from `Bool?` must be its inverse. Every operation reads its operands only through `from(_:)` and returns only those three values.
- Truth tables are Strong Kleene: `false` decides `and` and `nand`, `true` decides `or` and `nor`, and a false antecedent or a true consequent decides `implies`. Any other combination with an unknown operand gives unknown.
- `xor`, `xnor` and `iff` give unknown whenever either operand is unknown.
- `not` swaps true and false and keeps unknown. De Morgan's laws hold over all three values.
- `and`, `or`, `nand`, `nor` and `implies`, and their operators, skip the right operand when the left one decides the result. An unknown left operand never decides, so the right operand is then evaluated.
- The builders evaluate every expression in the block; they never skip one. `all` is conjunction with `true` as identity, so an empty block or an untaken `if` gives `true`. `any` is disjunction with `false` as identity. `none` is the negation of `any`, so an empty block gives `true`.
- `==`, `!=` and `??` between `Bool?` and `Bool` keep their standard library meaning; the package does not make them ternary.
