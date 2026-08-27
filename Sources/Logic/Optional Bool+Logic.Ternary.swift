extension Optional: Logic.`Protocol` where Wrapped == Bool {}

extension Optional: Logic.Ternary.`Protocol` where Wrapped == Bool {

    @inlinable
    public static var `true`: Bool? { true }

    @inlinable
    public static var `false`: Bool? { false }

    @inlinable
    public static var unknown: Bool? { nil }

    @inlinable
    public static func from(_ self: Self) -> Bool? { self }

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

    public init<T: Logic.Ternary.`Protocol`>(
        _ t: T
    ) {
        self = T.from(t)
    }
}
