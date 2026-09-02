import Testing
import Logic_Standard_Library_Integration

@testable import Logic_Ternary

@Suite
struct `Optional Logic Ternary Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

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
    func `explicit Collapse Accessors`() {
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
