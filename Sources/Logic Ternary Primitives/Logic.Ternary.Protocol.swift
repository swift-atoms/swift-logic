// Logic.Ternary.Protocol.swift

extension Logic.Ternary {
    /// A type that represents three-valued (ternary) logic.
    ///
    /// Ternary logic extends classical boolean logic with a third value representing "unknown" or "indeterminate". Conforming types gain all Strong Kleene logic operators (`&&`, `||`, `!`, `^`, `!&&`, `!||`, `!^`) through protocol extensions, enabling SQL-like three-valued reasoning.
    ///
    /// This protocol extends `Logic.Protocol` by adding the `unknown` value and
    /// requiring an initializer that accepts `Bool?`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// enum Tribool: Logic.Ternary.Protocol {
    ///     case yes, no, maybe
    ///
    ///     static var `true`: Tribool { .yes }
    ///     static var `false`: Tribool { .no }
    ///     static var unknown: Tribool { .maybe }
    ///
    ///     static func from(_ value: Tribool) -> Bool? {
    ///         switch value {
    ///         case .yes: true
    ///         case .no: false
    ///         case .maybe: nil
    ///         }
    ///     }
    ///
    ///     init(_ bool: Bool?) {
    ///         switch bool {
    ///         case true: self = .yes
    ///         case false: self = .no
    ///         case nil: self = .maybe
    ///         }
    ///     }
    ///
    ///     init(_ bool: Bool) {
    ///         self.init(bool as Bool?)
    ///     }
    /// }
    ///
    /// let a = Tribool.yes
    /// let b = Tribool.maybe
    /// let result = a && b
    /// // result = .maybe (unknown)
    /// ```
    public protocol `Protocol`: Logic.`Protocol` {
        /// The unknown/indeterminate value.
        static var unknown: Self { get }

        /// Creates a ternary value from an optional Bool.
        ///
        /// - Parameter bool: `true`, `false`, or `nil` for unknown.
        init(_ bool: Bool?)
    }
}
