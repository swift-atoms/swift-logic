@inlinable
public func && <T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () -> T
) -> T {
    if T.from(lhs).isFalse { return .false }
    return Logic.Ternary._and(lhs, rhs())
}

@inlinable
public func || <T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () -> T
) -> T {
    if T.from(lhs).isTrue { return .true }
    return Logic.Ternary._or(lhs, rhs())
}

@inlinable
public func !&& <T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () -> T
) -> T {
    if T.from(lhs).isFalse { return .true }
    return Logic.Ternary._nand(lhs, rhs())
}

@inlinable
public func !|| <T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () -> T
) -> T {
    if T.from(lhs).isTrue { return .false }
    return Logic.Ternary._nor(lhs, rhs())
}

extension Logic.Ternary {

    @inlinable
    public static func and<T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () -> T
    ) -> T {
        if T.from(lhs).isFalse { return .false }
        return _and(lhs, rhs())
    }

    @inlinable
    public static func or<T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () -> T
    ) -> T {
        if T.from(lhs).isTrue { return .true }
        return _or(lhs, rhs())
    }

    @inlinable
    public static func nand<T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () -> T
    ) -> T {
        if T.from(lhs).isFalse { return .true }
        return _nand(lhs, rhs())
    }

    @inlinable
    public static func nor<T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () -> T
    ) -> T {
        if T.from(lhs).isTrue { return .false }
        return _nor(lhs, rhs())
    }

    @inlinable
    public static func implies<T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () -> T
    ) -> T {
        if T.from(lhs).isFalse { return .true }
        return _implies(lhs, rhs())
    }
}
