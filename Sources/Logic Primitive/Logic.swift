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

/// Namespace for logic types and operations.
///
/// Logic primitives provide foundational types and protocols for implementing
/// various logic systems: binary (classical), ternary (three-valued), and beyond.
///
/// ## Example
///
/// ```swift
/// // Binary logic
/// let a: Bool = true
/// let b: Bool = false
/// let result = a && b  // false
///
/// // Using the Logic namespace
/// let and = Logic.and(a, b)  // false
/// ```
public enum Logic {}

// Logic.Protocol is declared in Logic.Protocol.swift (single-type-per-file).

// MARK: - Bool Conformance

extension Bool: Logic.`Protocol` {
    // Swift's Bool already has `true` and `false` as language-level constructs.
    // We construct them from comparisons to avoid keyword conflicts.

    /// The true value of Boolean logic.
    @inlinable
    public static var `true`: Bool { 1 == 1 }

    /// The false value of Boolean logic.
    @inlinable
    public static var `false`: Bool { 1 == 0 }

    /// Returns the Boolean's truth value, which is never `nil`.
    @inlinable
    public static func from(_ value: Bool) -> Bool? {
        value
    }

    /// Creates a Boolean from the given Boolean value.
    @inlinable
    public init(_ bool: Bool) {
        self = bool
    }
}
