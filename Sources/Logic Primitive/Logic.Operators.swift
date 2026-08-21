extension Logic {

    @inlinable
    public static func and<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        switch (T.from(lhs), T.from(rhs)) {
        case (false, _), (_, false): return .false
        case (nil, _): return lhs
        case (_, nil): return rhs
        default: return .true
        }
    }
}

extension Logic {

    @inlinable
    public static func or<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        switch (T.from(lhs), T.from(rhs)) {
        case (true, _), (_, true): return .true
        case (nil, _): return lhs
        case (_, nil): return rhs
        default: return .false
        }
    }
}

extension Logic {

    @inlinable
    public static func not<T: `Protocol`>(_ value: T) -> T {
        guard let v = T.from(value) else {
            return value
        }
        return T(!v)
    }
}

extension Logic {

    @inlinable
    public static func xor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        guard let l = T.from(lhs) else { return lhs }
        guard let r = T.from(rhs) else { return rhs }
        return T(l != r)
    }
}

extension Logic {

    @inlinable
    public static func nand<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        Self.not(Self.and(lhs, rhs))
    }
}

extension Logic {

    @inlinable
    public static func nor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        Self.not(Self.or(lhs, rhs))
    }
}

extension Logic {

    @inlinable
    public static func xnor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        Self.not(Self.xor(lhs, rhs))
    }
}

extension Logic {

    @inlinable
    public static func implies<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        Self.or(Self.not(lhs), rhs)
    }
}

extension Logic {

    @inlinable
    public static func iff<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        Self.xnor(lhs, rhs)
    }
}
