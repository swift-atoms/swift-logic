# swift-logic

Use this package when a condition can be true, false or not yet known, and the unknown case must carry through a computation instead of being forced to a Boolean early. It gives three-valued (Strong Kleene) logic over `Bool?`, where `nil` means unknown, and over any type you conform to `Logic.Ternary.Protocol`. If every value is always known, plain `Bool` is the right choice.

## Model

- `Logic.Ternary.Protocol` describes a three-valued type: the static values `true`, `false` and `unknown`, `from(_:)` mapping a value to `Bool?` (`nil` for unknown), and `init(_: Bool)` / `init(_: Bool?)`. `Optional<Bool>` conforms, so `Bool?` works out of the box.
- Operations are static functions on `Logic.Ternary`, generic over any conforming `T`, each returning a new `T`: `and`, `or`, `not`, `xor`, `xnor`, `iff` (same as `xnor`), `nand`, `nor` and `implies`.
- Operators for conforming types: `&&`, `||`, prefix `!`, `^` (xor), `!^` (xnor, comparison precedence), `!&&` (nand, conjunction precedence) and `!||` (nor, disjunction precedence). `implies` has no operator.
- Result builders `Logic.Ternary.Builder<T>.All`, `.Any` and `.None`, used through `Logic.Ternary.all`, `any` and `none`, or `Bool?.all`, `Bool?.any` and `Bool?.none`. Builder blocks accept `T` and plain `Bool` expressions, `if`, `if`/`else` and `for` loops.
- On `Bool?`: `isTrue`, `isFalse`, `isUnknown`, and `init(_:)` from any conforming value.

## Laws

- Strong Kleene truth tables: `false` decides `and` and `nand`; `true` decides `or` and `nor`; a false antecedent or a true consequent decides `implies`. Otherwise any unknown operand gives unknown.
- `xor`, `xnor` and `iff` return unknown whenever either operand is unknown.
- `not` swaps true and false and keeps unknown. De Morgan's laws hold over all three values.
- `and`, `or`, `nand`, `nor` and `implies` take the right operand as an autoclosure and skip it when the left operand decides the result; with an unknown left operand the right operand is evaluated. When the right operand throws, the typed error is rethrown unchanged.
- Builders: `all` is conjunction with `true` for an empty block or an untaken `if`; `any` is disjunction with `false` as identity; `none` is the negation of `any`, so an empty block gives `true`.
- `==`, `!=` and `??` between `Bool?` and `Bool` keep standard library meaning; the package does not change them.

## Example

```swift
import Logic

let a: Bool? = true
let b: Bool? = false
let c: Bool? = nil

let unknown: Bool? = (a && b) || c   // nil
let known: Bool? = (a || c) && b     // false

let values: [Bool?] = [true, nil, true]
let result = Bool?.all {
    for v in values {
        v
    }
}
// result == nil
```
