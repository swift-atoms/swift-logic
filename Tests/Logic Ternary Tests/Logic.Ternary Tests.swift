import Testing
import Logic_Standard_Library_Integration

@testable import Logic_Ternary

enum Case {}

extension Case {
    struct Binary: CustomTestStringConvertible, Sendable {
        let lhs: Bool?
        let rhs: Bool?
        let expected: Bool?
    }
}

extension Case.Binary {
    var testDescription: String {
        "\(lhs.map(String.init(describing:)) ?? "nil") → \(rhs.map(String.init(describing:)) ?? "nil") = \(expected.map(String.init(describing:)) ?? "nil")"
    }
}

extension Case {
    struct Unary: CustomTestStringConvertible, Sendable {
        let input: Bool?
        let expected: Bool?
    }
}

extension Case.Unary {
    var testDescription: String {
        "\(input.map(String.init(describing:)) ?? "nil") → \(expected.map(String.init(describing:)) ?? "nil")"
    }
}

extension Logic.Ternary {
    @Suite
    struct Test {
        static let notCases: [Case.Unary] = [
            .init(input: true, expected: false),
            .init(input: false, expected: true),
            .init(input: nil, expected: nil),
        ]

        @Test(arguments: notCases)
        func not(_ testCase: Case.Unary) {
            #expect((!testCase.input) == testCase.expected)
        }

        @Test(arguments: [true, false])
        func involution(_ value: Bool) {
            #expect((!(!value)) == value)
        }
    }
}

extension Logic.Ternary.Test {

    @Suite
    struct AND {
        static let andCases: [Case.Binary] = [

            .init(lhs: false, rhs: false, expected: false),
            .init(lhs: false, rhs: true, expected: false),
            .init(lhs: true, rhs: false, expected: false),
            .init(lhs: true, rhs: true, expected: true),

            .init(lhs: false, rhs: nil, expected: false),
            .init(lhs: nil, rhs: false, expected: false),

            .init(lhs: true, rhs: nil, expected: nil),
            .init(lhs: nil, rhs: true, expected: nil),
            .init(lhs: nil, rhs: nil, expected: nil),
        ]

        @Test(arguments: andCases)
        func and(_ testCase: Case.Binary) {
            let result = Logic.Ternary.and(testCase.lhs, testCase.rhs)
            #expect(result == testCase.expected)
        }

        @Test(arguments: andCases)
        func `and Operator`(_ testCase: Case.Binary) {
            let result: Bool? = testCase.lhs && testCase.rhs
            #expect(result == testCase.expected)
        }
    }

    @Suite
    struct OR {
        static let orCases: [Case.Binary] = [

            .init(lhs: false, rhs: false, expected: false),
            .init(lhs: false, rhs: true, expected: true),
            .init(lhs: true, rhs: false, expected: true),
            .init(lhs: true, rhs: true, expected: true),

            .init(lhs: true, rhs: nil, expected: true),
            .init(lhs: nil, rhs: true, expected: true),

            .init(lhs: false, rhs: nil, expected: nil),
            .init(lhs: nil, rhs: false, expected: nil),
            .init(lhs: nil, rhs: nil, expected: nil),
        ]

        @Test(arguments: orCases)
        func or(_ testCase: Case.Binary) {
            let result = Logic.Ternary.or(testCase.lhs, testCase.rhs)
            #expect(result == testCase.expected)
        }

        @Test(arguments: orCases)
        func `or Operator`(_ testCase: Case.Binary) {
            let result: Bool? = testCase.lhs || testCase.rhs
            #expect(result == testCase.expected)
        }
    }

    @Suite
    struct XOR {
        static let xorCases: [Case.Binary] = [

            .init(lhs: false, rhs: false, expected: false),
            .init(lhs: false, rhs: true, expected: true),
            .init(lhs: true, rhs: false, expected: true),
            .init(lhs: true, rhs: true, expected: false),

            .init(lhs: false, rhs: nil, expected: nil),
            .init(lhs: true, rhs: nil, expected: nil),
            .init(lhs: nil, rhs: false, expected: nil),
            .init(lhs: nil, rhs: true, expected: nil),
            .init(lhs: nil, rhs: nil, expected: nil),
        ]

        @Test(arguments: xorCases)
        func xor(_ testCase: Case.Binary) {
            #expect((testCase.lhs ^ testCase.rhs) == testCase.expected)
        }
    }

    @Suite
    struct XNOR {
        static let xnorCases: [Case.Binary] = [

            .init(lhs: false, rhs: false, expected: true),
            .init(lhs: false, rhs: true, expected: false),
            .init(lhs: true, rhs: false, expected: false),
            .init(lhs: true, rhs: true, expected: true),

            .init(lhs: false, rhs: nil, expected: nil),
            .init(lhs: true, rhs: nil, expected: nil),
            .init(lhs: nil, rhs: false, expected: nil),
            .init(lhs: nil, rhs: true, expected: nil),
            .init(lhs: nil, rhs: nil, expected: nil),
        ]

        @Test(arguments: xnorCases)
        func xnor(_ testCase: Case.Binary) {
            #expect((testCase.lhs !^ testCase.rhs) == testCase.expected)
        }

        @Test(arguments: xnorCases)
        func iff(_ testCase: Case.Binary) {

            #expect(Logic.Ternary.iff(testCase.lhs, testCase.rhs) == testCase.expected)
        }
    }

    @Suite
    struct NAND {
        static let nandCases: [Case.Binary] = [

            .init(lhs: false, rhs: false, expected: true),
            .init(lhs: false, rhs: true, expected: true),
            .init(lhs: true, rhs: false, expected: true),
            .init(lhs: true, rhs: true, expected: false),

            .init(lhs: false, rhs: nil, expected: true),
            .init(lhs: nil, rhs: false, expected: true),

            .init(lhs: true, rhs: nil, expected: nil),
            .init(lhs: nil, rhs: true, expected: nil),
            .init(lhs: nil, rhs: nil, expected: nil),
        ]

        @Test(arguments: nandCases)
        func nand(_ testCase: Case.Binary) {
            let result: Bool? = testCase.lhs !&& testCase.rhs
            #expect(result == testCase.expected)
        }
    }

    @Suite
    struct NOR {
        static let norCases: [Case.Binary] = [

            .init(lhs: false, rhs: false, expected: true),
            .init(lhs: false, rhs: true, expected: false),
            .init(lhs: true, rhs: false, expected: false),
            .init(lhs: true, rhs: true, expected: false),

            .init(lhs: true, rhs: nil, expected: false),
            .init(lhs: nil, rhs: true, expected: false),

            .init(lhs: false, rhs: nil, expected: nil),
            .init(lhs: nil, rhs: false, expected: nil),
            .init(lhs: nil, rhs: nil, expected: nil),
        ]

        @Test(arguments: norCases)
        func nor(_ testCase: Case.Binary) {
            let result: Bool? = testCase.lhs !|| testCase.rhs
            #expect(result == testCase.expected)
        }
    }

    @Suite
    struct Implication {
        static let implicationCases: [Case.Binary] = [
            .init(lhs: true, rhs: true, expected: true),
            .init(lhs: true, rhs: false, expected: false),
            .init(lhs: true, rhs: nil, expected: nil),

            .init(lhs: false, rhs: true, expected: true),
            .init(lhs: false, rhs: false, expected: true),
            .init(lhs: false, rhs: nil, expected: true),

            .init(lhs: nil, rhs: true, expected: true),
            .init(lhs: nil, rhs: false, expected: nil),
            .init(lhs: nil, rhs: nil, expected: nil),
        ]

        @Test(arguments: implicationCases)
        func implies(_ testCase: Case.Binary) {
            let result = Logic.Ternary.implies(testCase.lhs, testCase.rhs)
            #expect(result == testCase.expected)
        }

        @Test(arguments: implicationCases)
        func `matches Disjunctive Form`(_ testCase: Case.Binary) {
            let result: Bool? = !testCase.lhs || testCase.rhs
            #expect(result == testCase.expected)
        }
    }

    @Suite
    struct `Short Circuit` {
        @Test
        func `and Short Circuits On False`() {
            var evaluated = false
            func rhs() -> Bool? {
                evaluated = true
                return true
            }
            let result: Bool? = (false as Bool?) && rhs()
            #expect(result == .some(false))
            #expect(evaluated == false)
        }

        @Test
        func `and Evaluates Rhs When Undetermined`() {
            var evaluated = false
            func rhs() -> Bool? {
                evaluated = true
                return true
            }
            let result: Bool? = (nil as Bool?) && rhs()
            #expect(result == nil)
            #expect(evaluated == true)
        }

        @Test
        func `or Short Circuits On True`() {
            var evaluated = false
            func rhs() -> Bool? {
                evaluated = true
                return false
            }
            let result: Bool? = (true as Bool?) || rhs()
            #expect(result == .some(true))
            #expect(evaluated == false)
        }

        @Test
        func `nand Short Circuits On False`() {
            var evaluated = false
            func rhs() -> Bool? {
                evaluated = true
                return true
            }
            let result: Bool? = (false as Bool?) !&& rhs()
            #expect(result == .some(true))
            #expect(evaluated == false)
        }

        @Test
        func `nor Short Circuits On True`() {
            var evaluated = false
            func rhs() -> Bool? {
                evaluated = true
                return false
            }
            let result: Bool? = (true as Bool?) !|| rhs()
            #expect(result == .some(false))
            #expect(evaluated == false)
        }

        @Test
        func `implies Short Circuits On False Antecedent`() {
            var evaluated = false
            func rhs() -> Bool? {
                evaluated = true
                return false
            }
            let result = Logic.Ternary.implies(false as Bool?, rhs())
            #expect(result == .some(true))
            #expect(evaluated == false)
        }

        @Test
        func `static And Short Circuits On False`() {
            var evaluated = false
            func rhs() -> Bool? {
                evaluated = true
                return true
            }
            let result = Logic.Ternary.and(false as Bool?, rhs())
            #expect(result == .some(false))
            #expect(evaluated == false)
        }

        @Test
        func `static Or Short Circuits On True`() {
            var evaluated = false
            func rhs() -> Bool? {
                evaluated = true
                return false
            }
            let result = Logic.Ternary.or(true as Bool?, rhs())
            #expect(result == .some(true))
            #expect(evaluated == false)
        }
    }

    @Suite
    struct `De Morgan` {
        static let values: [Bool?] = [true, false, nil]

        @Test(arguments: values, values)
        func `de Morgan And`(_ a: Bool?, _ b: Bool?) {

            let lhs: Bool? = !(a && b)
            let rhs: Bool? = !a || !b
            #expect(lhs == rhs)
        }

        @Test(arguments: values, values)
        func `de Morgan Or`(_ a: Bool?, _ b: Bool?) {

            let lhs: Bool? = !(a || b)
            let rhs: Bool? = !a && !b
            #expect(lhs == rhs)
        }
    }

    @Suite
    struct `Complex Expression` {
        @Test
        func `mixed Values`() {
            let a: Bool? = true
            let b: Bool? = false
            let c: Bool? = nil

            let aAndB: Bool? = a && b
            let result1: Bool? = aAndB || c
            #expect(result1 == nil)

            let bOrC: Bool? = b || c
            let result2: Bool? = a && bOrC
            #expect(result2 == nil)

            let aOrC: Bool? = a || c
            let result3: Bool? = aOrC && b
            #expect(result3 == .some(false))
        }
    }
}
