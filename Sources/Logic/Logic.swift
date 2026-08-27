public enum Logic {}

extension Bool: Logic.`Protocol` {

    @inlinable
    public static var `true`: Bool { 1 == 1 }

    @inlinable
    public static var `false`: Bool { 1 == 0 }

    @inlinable
    public static func from(_ value: Bool) -> Bool? {
        value
    }

    @inlinable
    public init(_ bool: Bool) {
        self = bool
    }
}
