public import Logic_Ternary

extension Optional: Logic.Ternary.`Protocol` where Wrapped == Bool {

    @inlinable
    public static var `true`: Bool? { true }

    @inlinable
    public static var `false`: Bool? { false }

    @inlinable
    public static var unknown: Bool? { nil }

    @inlinable
    public static func from(_ value: Self) -> Bool? { value }

    @inlinable
    public init(_ bool: Bool) {
        self = bool
    }

    @inlinable
    public init(_ bool: Bool?) {
        self = bool
    }
}

extension Optional where Wrapped == Bool {

    public init<T: Logic.Ternary.`Protocol`>(_ value: T) {
        self = T.from(value)
    }

    @inlinable
    public var isTrue: Bool { self == .some(true) }

    @inlinable
    public var isFalse: Bool { self == .some(false) }

    @inlinable
    public var isUnknown: Bool { self == nil }

    @inlinable
    public static func all(@Logic.Ternary.Builder<Bool?>.All _ builder: () -> Bool?) -> Bool? {
        builder()
    }

    @inlinable
    public static func any(@Logic.Ternary.Builder<Bool?>.`Any` _ builder: () -> Bool?) -> Bool? {
        builder()
    }

    @inlinable
    public static func none(@Logic.Ternary.Builder<Bool?>.None _ builder: () -> Bool?) -> Bool? {
        builder()
    }
}
