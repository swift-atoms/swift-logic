import Logic
import Testing

@testable import Logic

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
    struct `Ternary operations follow Strong Kleene logic and short circuit when decisive` {
        static let notCases: [Case.Unary] = [
            .init(input: true, expected: false),
            .init(input: false, expected: true),
            .init(input: nil, expected: nil),
        ]

        @Test(arguments: notCases)
        func `Ternary negation reverses known values and preserves unknown`(_ testCase: Case.Unary) {
            #expect((!testCase.input) == testCase.expected)
        }

        @Test(arguments: [true, false])
        func `Applying Boolean negation twice restores the original value`(_ value: Bool) {
            #expect((!(!value)) == value)
        }
    }
}

extension Logic.Ternary.`Ternary operations follow Strong Kleene logic and short circuit when decisive` {

    @Suite
    struct `Ternary conjunction follows the Strong Kleene truth table` {
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
        func `Ternary conjunction returns the Strong Kleene result`(_ testCase: Case.Binary) {
            let result = Logic.Ternary.and(testCase.lhs, testCase.rhs)
            #expect(result == testCase.expected)
        }

        @Test(arguments: andCases)
        func `The ternary conjunction operator returns the Strong Kleene result`(_ testCase: Case.Binary) {
            let result: Bool? = testCase.lhs && testCase.rhs
            #expect(result == testCase.expected)
        }
    }

    @Suite
    struct `Ternary disjunction follows the Strong Kleene truth table` {
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
        func `Ternary disjunction returns the Strong Kleene result`(_ testCase: Case.Binary) {
            let result = Logic.Ternary.or(testCase.lhs, testCase.rhs)
            #expect(result == testCase.expected)
        }

        @Test(arguments: orCases)
        func `The ternary disjunction operator returns the Strong Kleene result`(_ testCase: Case.Binary) {
            let result: Bool? = testCase.lhs || testCase.rhs
            #expect(result == testCase.expected)
        }
    }

    @Suite
    struct `Ternary exclusive disjunction propagates unknown operands` {
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
        func `The ternary exclusive disjunction operator returns the truth table result`(_ testCase: Case.Binary) {
            #expect((testCase.lhs ^ testCase.rhs) == testCase.expected)
        }
    }

    @Suite
    struct `Ternary equivalence agrees with negated exclusive disjunction` {
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
        func `The ternary equivalence operator returns the truth table result`(_ testCase: Case.Binary) {
            #expect((testCase.lhs !^ testCase.rhs) == testCase.expected)
        }

        @Test(arguments: xnorCases)
        func `Ternary iff returns the equivalence truth table result`(_ testCase: Case.Binary) {

            #expect(Logic.Ternary.iff(testCase.lhs, testCase.rhs) == testCase.expected)
        }
    }

    @Suite
    struct `Ternary NAND negates conjunction` {
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
        func `The ternary NAND operator returns the negated conjunction result`(_ testCase: Case.Binary) {
            let result: Bool? = testCase.lhs !&& testCase.rhs
            #expect(result == testCase.expected)
        }
    }

    @Suite
    struct `Ternary NOR negates disjunction` {
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
        func `The ternary NOR operator returns the negated disjunction result`(_ testCase: Case.Binary) {
            let result: Bool? = testCase.lhs !|| testCase.rhs
            #expect(result == testCase.expected)
        }
    }

    @Suite
    struct `Ternary implication agrees with disjunction of the negated antecedent` {
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
        func `Ternary implication returns the truth table result`(_ testCase: Case.Binary) {
            let result = Logic.Ternary.implies(testCase.lhs, testCase.rhs)
            #expect(result == testCase.expected)
        }

        @Test(arguments: implicationCases)
        func `Disjunction with a negated antecedent returns the implication result`(_ testCase: Case.Binary) {
            let result: Bool? = !testCase.lhs || testCase.rhs
            #expect(result == testCase.expected)
        }
    }

    @Suite
    struct `Ternary operations skip or evaluate deferred operands as required` {
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
    struct `Ternary negation obeys De Morgan laws` {
        static let values: [Bool?] = [true, false, nil]

        @Test(arguments: values, values)
        func `Negated ternary conjunction equals disjunction of negated operands`(_ a: Bool?, _ b: Bool?) {

            let lhs: Bool? = !(a && b)
            let rhs: Bool? = !a || !b
            #expect(lhs == rhs)
        }

        @Test(arguments: values, values)
        func `Negated ternary disjunction equals conjunction of negated operands`(_ a: Bool?, _ b: Bool?) {

            let lhs: Bool? = !(a || b)
            let rhs: Bool? = !a && !b
            #expect(lhs == rhs)
        }
    }

    @Suite
    struct `Mixed ternary expressions preserve Strong Kleene results` {
        @Test
        func `Mixed ternary expressions propagate or resolve unknown values`() {
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
