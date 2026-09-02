extension Logic.Ternary {

    public protocol `Protocol` {

        static var `true`: Self { get }

        static var `false`: Self { get }

        static var unknown: Self { get }

        static func from(_ value: Self) -> Bool?

        init(_ bool: Bool)

        init(_ bool: Bool?)
    }
}
