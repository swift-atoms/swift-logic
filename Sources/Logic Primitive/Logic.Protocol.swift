// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-primitives
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

extension Logic {
    /// A type that represents a logic system with true and false values.
    ///
    /// Conforming types gain standard logic operators (`&&`, `||`, `!`, `^`)
    /// through protocol extensions. This is the base protocol for binary logic;
    /// multi-valued logics (ternary, fuzzy) extend this with additional values.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Bool already conforms implicitly through Swift's standard library
    /// // Custom types can conform:
    /// enum Bit: Logic.Protocol {
    ///     case zero, one
    ///
    ///     static var `true`: Bit { .one }
    ///     static var `false`: Bit { .zero }
    ///
    ///     static func from(_ value: Bit) -> Bool {
    ///         value == .one
    ///     }
    ///
    ///     init(_ bool: Bool) {
    ///         self = bool ? .one : .zero
    ///     }
    /// }
    /// ```
    public protocol `Protocol`: Sendable {
        /// The true value in this logic system.
        static var `true`: Self { get }

        /// The false value in this logic system.
        static var `false`: Self { get }

        /// Converts a value of this logic type to its boolean representation.
        ///
        /// For binary logic, this is a direct mapping. For multi-valued logics,
        /// this returns `nil` for values that are neither true nor false.
        static func from(_ value: Self) -> Bool?

        /// Creates a value from a boolean.
        ///
        /// - Parameter bool: The boolean value to convert.
        init(_ bool: Bool)
    }
}
