import Logic
import Testing

@testable import Logic

@Suite
struct `Optional ternary operations preserve unknown values and explicit collapse behavior` {
    @Suite struct `No optional ternary unit cases are defined` {}
    @Suite struct `No optional ternary boundary cases are defined` {}
    @Suite struct `No optional ternary integration cases are defined` {}

    static let values: [Bool?] = [true, false, nil]

    @Test(arguments: values, [true, false])
    func `equals Matches Standard Library Semantics`(_ lhs: Bool?, _ rhs: Bool) {

        let expected = lhs == Optional(rhs)
        #expect((lhs == rhs) == expected)
    }

    @Test(arguments: values, [true, false])
    func `not Equals Matches Standard Library Semantics`(_ lhs: Bool?, _ rhs: Bool) {
        let expected = lhs != Optional(rhs)
        #expect((lhs != rhs) == expected)
    }

    @Test(arguments: values, [true, false])
    func `coalesce Matches Standard Library Semantics`(_ lhs: Bool?, _ rhs: Bool) {
        let expected: Bool = if case .some(let value) = lhs { value } else { rhs }
        #expect((lhs ?? rhs) == expected)
    }

    @Test
    func `Explicit ternary accessors distinguish true false and unknown`() {
        #expect((true as Bool?).isTrue)
        #expect(!(false as Bool?).isTrue)
        #expect(!(nil as Bool?).isTrue)

        #expect(!(true as Bool?).isFalse)
        #expect((false as Bool?).isFalse)
        #expect(!(nil as Bool?).isFalse)

        #expect(!(true as Bool?).isUnknown)
        #expect(!(false as Bool?).isUnknown)
        #expect((nil as Bool?).isUnknown)
    }
}
