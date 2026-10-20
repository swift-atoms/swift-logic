import Logic
import Testing

@testable import Logic

@Suite
struct `Ternary builders combine expressions using Strong Kleene logic` {
    @Suite struct `No ternary builder unit cases are defined` {}
    @Suite struct `No ternary builder boundary cases are defined` {}
    @Suite struct `No ternary builder integration cases are defined` {}

    @Suite
    struct `The all builder combines included expressions with ternary conjunction` {

        @Test
        func `All true returns true`() {
            let result = Bool?.all {
                true
                true
                true
            }
            #expect(result == .some(true))
        }

        @Test
        func `Any false returns false`() {
            let result = Bool?.all {
                true
                false
                true
            }
            #expect(result == .some(false))
        }

        @Test
        func `Unknown with no false returns unknown`() {
            let result = Bool?.all {
                true
                nil as Bool?
                true
            }
            #expect(result == nil)
        }

        @Test
        func `False dominates unknown`() {
            let result = Bool?.all {
                nil as Bool?
                false
                nil as Bool?
            }
            #expect(result == .some(false))
        }

        @Test
        func `Empty block returns true`() {
            let result: Bool? = Bool?.all {
            }
            #expect(result == .some(true))
        }

        @Test
        func `A builder containing only true returns true`() {
            let result = Bool?.all {
                true
            }
            #expect(result == .some(true))
        }

        @Test
        func `A builder containing only false returns false`() {
            let result = Bool?.all {
                false
            }
            #expect(result == .some(false))
        }

        @Test
        func `A builder containing only unknown returns unknown`() {
            let result = Bool?.all {
                nil as Bool?
            }
            #expect(result == nil)
        }

        @Test
        func `The all builder includes a taken true branch`() {
            let condition = true
            let result = Bool?.all {
                true
                if condition {
                    true
                }
            }
            #expect(result == .some(true))
        }

        @Test
        func `Conditional inclusion - untaken branch is conjunction identity`() {
            let condition = false
            let result = Bool?.all {
                true
                if condition {
                    true
                }
            }

            #expect(result == .some(true))
        }

        @Test
        func `Conditional inclusion - taken branch contributes unknown`() {
            let condition = true
            let unknown: Bool? = nil
            let result = Bool?.all {
                true
                if condition {
                    unknown
                }
            }
            #expect(result == nil)
        }

        @Test
        func `The all builder evaluates the selected first branch`() {
            let condition = true
            let result = Bool?.all {
                if condition {
                    true
                } else {
                    false
                }
            }
            #expect(result == .some(true))
        }

        @Test
        func `The all builder evaluates the selected second branch`() {
            let condition = false
            let result = Bool?.all {
                if condition {
                    true
                } else {
                    false
                }
            }
            #expect(result == .some(false))
        }

        @Test
        func `The all builder returns true when every loop expression is true`() {
            let result = Bool?.all {
                for _ in 1...3 {
                    true
                }
            }
            #expect(result == .some(true))
        }

        @Test
        func `The all builder returns false when a loop expression is false`() {
            let values: [Bool?] = [true, false, true]
            let result = Bool?.all {
                for v in values {
                    v
                }
            }
            #expect(result == .some(false))
        }

        @Test
        func `The all builder preserves unknown when the other loop expressions are true`() {
            let values: [Bool?] = [true, nil, true]
            let result = Bool?.all {
                for v in values {
                    v
                }
            }
            #expect(result == nil)
        }
    }

    @Suite
    struct `The any builder combines included expressions with ternary disjunction` {

        @Test
        func `All false returns false`() {
            let result = Bool?.any {
                false
                false
                false
            }
            #expect(result == .some(false))
        }

        @Test
        func `Any true returns true`() {
            let result = Bool?.any {
                false
                true
                false
            }
            #expect(result == .some(true))
        }

        @Test
        func `Unknown with no true returns unknown`() {
            let result = Bool?.any {
                false
                nil as Bool?
                false
            }
            #expect(result == nil)
        }

        @Test
        func `True dominates unknown`() {
            let result = Bool?.any {
                nil as Bool?
                true
                nil as Bool?
            }
            #expect(result == .some(true))
        }

        @Test
        func `Empty block returns false`() {
            let result: Bool? = Bool?.any {
            }
            #expect(result == .some(false))
        }

        @Test
        func `A builder containing only true returns true`() {
            let result = Bool?.any {
                true
            }
            #expect(result == .some(true))
        }

        @Test
        func `A builder containing only false returns false`() {
            let result = Bool?.any {
                false
            }
            #expect(result == .some(false))
        }

        @Test
        func `A builder containing only unknown returns unknown`() {
            let result = Bool?.any {
                nil as Bool?
            }
            #expect(result == nil)
        }

        @Test
        func `Conditional inclusion - untaken branch is disjunction identity`() {
            let condition = false
            let result = Bool?.any {
                false
                if condition {
                    true
                }
            }

            #expect(result == .some(false))
        }
    }

    @Suite
    struct `The none builder negates ternary disjunction of included expressions` {

        @Test
        func `All false returns true`() {
            let result = Bool?.none {
                false
                false
                false
            }
            #expect(result == .some(true))
        }

        @Test
        func `Any true returns false`() {
            let result = Bool?.none {
                false
                true
                false
            }
            #expect(result == .some(false))
        }

        @Test
        func `Unknown with no true returns unknown`() {
            let result = Bool?.none {
                false
                nil as Bool?
                false
            }
            #expect(result == nil)
        }

        @Test
        func `True dominates unknown for NOR`() {
            let result = Bool?.none {
                nil as Bool?
                true
                nil as Bool?
            }

            #expect(result == .some(false))
        }

        @Test
        func `Empty block returns true`() {
            let result: Bool? = Bool?.none {
            }

            #expect(result == .some(true))
        }

        @Test
        func `Single true returns false`() {
            let result = Bool?.none {
                true
            }
            #expect(result == .some(false))
        }

        @Test
        func `Single false returns true`() {
            let result = Bool?.none {
                false
            }
            #expect(result == .some(true))
        }

        @Test
        func `Single unknown returns unknown`() {
            let result = Bool?.none {
                nil as Bool?
            }
            #expect(result == nil)
        }

        @Test
        func `Conditional inclusion - untaken branch is identity`() {
            let condition = false
            let result = Bool?.none {
                false
                if condition {
                    true
                }
            }

            #expect(result == .some(true))
        }
    }

    @Suite
    struct `Ternary builder methods lift and combine expression values` {

        @Test
        func `The all builder preserves an optional Boolean expression`() {
            let result = Logic.Ternary.Builder<Bool?>.All.buildExpression(true as Bool?)
            #expect(result == .some(true))
        }

        @Test
        func `The all builder lifts a Boolean expression to an optional value`() {
            let result = Logic.Ternary.Builder<Bool?>.All.buildExpression(true)
            #expect(result == .some(true))
        }

        @Test
        func `The all builder combines accumulated expressions with conjunction`() {

            let r1 = Logic.Ternary.Builder<Bool?>.All.buildPartialBlock(
                accumulated: true,
                next: true
            )
            #expect(r1 == .some(true))

            let r2 = Logic.Ternary.Builder<Bool?>.All.buildPartialBlock(
                accumulated: true,
                next: false
            )
            #expect(r2 == .some(false))

            let r3 = Logic.Ternary.Builder<Bool?>.All.buildPartialBlock(
                accumulated: true,
                next: nil
            )
            #expect(r3 == nil)

            let r4 = Logic.Ternary.Builder<Bool?>.All.buildPartialBlock(
                accumulated: nil,
                next: false
            )
            #expect(r4 == .some(false))
        }

        @Test
        func `The any builder combines accumulated expressions with disjunction`() {

            let r1 = Logic.Ternary.Builder<Bool?>.`Any`.buildPartialBlock(
                accumulated: false,
                next: false
            )
            #expect(r1 == .some(false))

            let r2 = Logic.Ternary.Builder<Bool?>.`Any`.buildPartialBlock(
                accumulated: false,
                next: true
            )
            #expect(r2 == .some(true))

            let r3 = Logic.Ternary.Builder<Bool?>.`Any`.buildPartialBlock(
                accumulated: false,
                next: nil
            )
            #expect(r3 == nil)

            let r4 = Logic.Ternary.Builder<Bool?>.`Any`.buildPartialBlock(
                accumulated: nil,
                next: true
            )
            #expect(r4 == .some(true))
        }

        @Test
        func `The none builder negates its final result and preserves unknown`() {

            let r1 = Logic.Ternary.Builder<Bool?>.None.buildFinalResult(true)
            #expect(r1 == .some(false))

            let r2 = Logic.Ternary.Builder<Bool?>.None.buildFinalResult(false)
            #expect(r2 == .some(true))

            let r3 = Logic.Ternary.Builder<Bool?>.None.buildFinalResult(nil)
            #expect(r3 == nil)
        }
    }

}
