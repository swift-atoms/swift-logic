extension Optional where Wrapped == Bool {

    @inlinable
    public var isTrue: Bool { self == .some(true) }

    @inlinable
    public var isFalse: Bool { self == .some(false) }

    @inlinable
    public var isUnknown: Bool { self == nil }
}
