@available(
    *,
    deprecated,
    message:
        "collapses Kleene unknown to a definite verdict — compose with Bool?.all/any, &&, ||, ! instead; if the collapse is intended, spell it explicitly with .isTrue / .isFalse / .isUnknown"
)
public func == (lhs: Bool?, rhs: Bool) -> Bool {
    lhs == .some(rhs)
}

@available(
    *,
    deprecated,
    message:
        "collapses Kleene unknown to a definite verdict — compose with Bool?.all/any, &&, ||, ! instead; if the collapse is intended, spell it explicitly with .isTrue / .isFalse / .isUnknown"
)
public func == (lhs: Bool, rhs: Bool?) -> Bool {
    .some(lhs) == rhs
}

@available(
    *,
    deprecated,
    message:
        "collapses Kleene unknown — negate with ! (Kleene) instead; if the collapse is intended, spell it explicitly with .isTrue / .isFalse / .isUnknown"
)
public func != (lhs: Bool?, rhs: Bool) -> Bool {
    lhs != .some(rhs)
}

@available(
    *,
    deprecated,
    message:
        "collapses Kleene unknown — negate with ! (Kleene) instead; if the collapse is intended, spell it explicitly with .isTrue / .isFalse / .isUnknown"
)
public func != (lhs: Bool, rhs: Bool?) -> Bool {
    .some(lhs) != rhs
}

@inlinable
public func != (lhs: Bool, rhs: Bool) -> Bool {
    !(lhs == rhs)
}

@available(
    *,
    deprecated,
    message:
        "collapses Kleene unknown — a nil-coalesced verdict silently converts 'not assessed' into a definite value; compose with Kleene operators or spell the collapse explicitly with .isTrue / .isFalse / .isUnknown"
)
public func ?? (lhs: Bool?, rhs: @autoclosure () -> Bool) -> Bool {
    switch lhs {
    case .some(let value): value
    case nil: rhs()
    }
}

extension Optional where Wrapped == Bool {

    @inlinable
    public var isTrue: Bool { self == .some(true) }

    @inlinable
    public var isFalse: Bool { self == .some(false) }

    @inlinable
    public var isUnknown: Bool { self == nil }
}
