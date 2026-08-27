extension Logic.Ternary {

    public protocol `Protocol`: Logic.`Protocol` {

        static var unknown: Self { get }

        init(_ bool: Bool?)
    }
}
