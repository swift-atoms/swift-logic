extension Logic {

    public enum Ternary {}
}

extension Logic.Ternary {
    @inlinable @inline(always)
    package static func _and<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        if T.from(lhs).isFalse { return .false }
        if T.from(rhs).isFalse { return .false }
        if T.from(lhs) == nil || T.from(rhs) == nil { return .unknown }
        return .true
    }

    @inlinable @inline(always)
    package static func _or<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        if T.from(lhs).isTrue { return .true }
        if T.from(rhs).isTrue { return .true }
        if T.from(lhs) == nil || T.from(rhs) == nil { return .unknown }
        return .false
    }

    @inlinable @inline(always)
    package static func _nand<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        if T.from(lhs).isFalse { return .true }
        if T.from(rhs).isFalse { return .true }
        if T.from(lhs) == nil || T.from(rhs) == nil { return .unknown }
        return .false
    }

    @inlinable @inline(always)
    package static func _nor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        if T.from(lhs).isTrue { return .false }
        if T.from(rhs).isTrue { return .false }
        if T.from(lhs) == nil || T.from(rhs) == nil { return .unknown }
        return .true
    }

    @inlinable @inline(always)
    package static func _implies<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        if T.from(lhs).isFalse { return .true }
        if T.from(rhs).isTrue { return .true }
        if T.from(lhs) == nil || T.from(rhs) == nil { return .unknown }
        return .false
    }
}

extension Logic.Ternary {

    @inlinable
    public static func and<E: Swift.Error, T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () throws(E) -> T
    ) throws(E) -> T {
        if T.from(lhs).isFalse { return .false }
        return _and(lhs, try rhs())
    }
}

@inlinable
public func && <E: Swift.Error, T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () throws(E) -> T
) throws(E) -> T {
    if T.from(lhs).isFalse { return .false }
    return Logic.Ternary._and(lhs, try rhs())
}

extension Logic.Ternary {

    @inlinable
    public static func or<E: Swift.Error, T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () throws(E) -> T
    ) throws(E) -> T {
        if T.from(lhs).isTrue { return .true }
        return _or(lhs, try rhs())
    }
}

@inlinable
public func || <E: Swift.Error, T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () throws(E) -> T
) throws(E) -> T {
    if T.from(lhs).isTrue { return .true }
    return Logic.Ternary._or(lhs, try rhs())
}

extension Logic.Ternary {

    @inlinable
    public static func not<T: `Protocol`>(_ value: T) -> T {
        switch T.from(value) {
        case true: return .false
        case false: return .true
        case nil: return .unknown
        }
    }
}

@inlinable
public prefix func ! <T: Logic.Ternary.`Protocol`>(value: T) -> T {
    Logic.Ternary.not(value)
}

extension Logic.Ternary {

    @inlinable
    public static func xor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        guard let l = T.from(lhs), let r = T.from(rhs) else { return .unknown }
        return l != r ? .true : .false
    }
}

@inlinable
public func ^ <T: Logic.Ternary.`Protocol`>(lhs: T, rhs: T) -> T {
    Logic.Ternary.xor(lhs, rhs)
}

infix operator !&& : LogicalConjunctionPrecedence

extension Logic.Ternary {

    @inlinable
    public static func nand<E: Swift.Error, T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () throws(E) -> T
    ) throws(E) -> T {
        if T.from(lhs).isFalse { return .true }
        return _nand(lhs, try rhs())
    }
}

@inlinable
public func !&& <E: Swift.Error, T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () throws(E) -> T
) throws(E) -> T {
    if T.from(lhs).isFalse { return .true }
    return Logic.Ternary._nand(lhs, try rhs())
}

infix operator !|| : LogicalDisjunctionPrecedence

extension Logic.Ternary {

    @inlinable
    public static func nor<E: Swift.Error, T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () throws(E) -> T
    ) throws(E) -> T {
        if T.from(lhs).isTrue { return .false }
        return _nor(lhs, try rhs())
    }
}

@inlinable
public func !|| <E: Swift.Error, T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () throws(E) -> T
) throws(E) -> T {
    if T.from(lhs).isTrue { return .false }
    return Logic.Ternary._nor(lhs, try rhs())
}

extension Logic.Ternary {

    @inlinable
    public static func implies<E: Swift.Error, T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () throws(E) -> T
    ) throws(E) -> T {
        if T.from(lhs).isFalse { return .true }
        return _implies(lhs, try rhs())
    }
}

extension Logic.Ternary {

    @inlinable
    public static func iff<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        xnor(lhs, rhs)
    }
}

infix operator !^ : ComparisonPrecedence

extension Logic.Ternary {

    @inlinable
    public static func xnor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        guard let l = T.from(lhs), let r = T.from(rhs) else { return .unknown }
        return l == r ? .true : .false
    }
}

@inlinable
public func !^ <T: Logic.Ternary.`Protocol`>(lhs: T, rhs: T) -> T {
    Logic.Ternary.xnor(lhs, rhs)
}
