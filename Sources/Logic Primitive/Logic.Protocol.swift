extension Logic {

    public protocol `Protocol`: Sendable {

        static var `true`: Self { get }

        static var `false`: Self { get }

        static func from(_ value: Self) -> Bool?

        init(_ bool: Bool)
    }
}
