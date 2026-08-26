import Testing

@testable import Logic

extension Logic {
    @Suite
    struct Test {

        @Test
        func and() {
            #expect(Logic.and(true, true) == true)
            #expect(Logic.and(true, false) == false)
            #expect(Logic.and(false, true) == false)
            #expect(Logic.and(false, false) == false)
        }

        @Test
        func or() {
            #expect(Logic.or(true, true) == true)
            #expect(Logic.or(true, false) == true)
            #expect(Logic.or(false, true) == true)
            #expect(Logic.or(false, false) == false)
        }

        @Test
        func not() {
            #expect(Logic.not(true) == false)
            #expect(Logic.not(false) == true)
        }

        @Test
        func xor() {
            #expect(Logic.xor(true, true) == false)
            #expect(Logic.xor(true, false) == true)
            #expect(Logic.xor(false, true) == true)
            #expect(Logic.xor(false, false) == false)
        }

        @Test
        func nand() {
            #expect(Logic.nand(true, true) == false)
            #expect(Logic.nand(true, false) == true)
            #expect(Logic.nand(false, true) == true)
            #expect(Logic.nand(false, false) == true)
        }

        @Test
        func nor() {
            #expect(Logic.nor(true, true) == false)
            #expect(Logic.nor(true, false) == false)
            #expect(Logic.nor(false, true) == false)
            #expect(Logic.nor(false, false) == true)
        }

        @Test
        func xnor() {
            #expect(Logic.xnor(true, true) == true)
            #expect(Logic.xnor(true, false) == false)
            #expect(Logic.xnor(false, true) == false)
            #expect(Logic.xnor(false, false) == true)
        }

        @Test
        func implies() {
            #expect(Logic.implies(true, true) == true)
            #expect(Logic.implies(true, false) == false)
            #expect(Logic.implies(false, true) == true)
            #expect(Logic.implies(false, false) == true)
        }

        @Test
        func iff() {
            #expect(Logic.iff(true, true) == true)
            #expect(Logic.iff(true, false) == false)
            #expect(Logic.iff(false, true) == false)
            #expect(Logic.iff(false, false) == true)
        }
    }
}

extension Bool {
    @Suite
    struct Test {

        @Test
        func `bool Conformance`() {

            let t: Bool = .true
            let f: Bool = .false

            #expect(t == true)
            #expect(f == false)
            #expect(Bool.from(true) == .some(true))
            #expect(Bool.from(false) == .some(false))
            #expect(Bool(true) == true)
            #expect(Bool(false) == false)
        }
    }
}
