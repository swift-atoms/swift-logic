extension Logic.Ternary {

    public enum Builder<T: Logic.Ternary.`Protocol`> {

        @resultBuilder
        public enum All {

            @inlinable
            public static func buildExpression(_ expression: T) -> T {
                expression
            }

            @inlinable
            public static func buildExpression(_ expression: Bool) -> T {
                T(expression)
            }

            @inlinable
            public static func buildPartialBlock(first: T) -> T {
                first
            }

            @inlinable
            public static func buildPartialBlock(first: Void) -> T {
                .true
            }

            @inlinable
            public static func buildPartialBlock(first: Never) -> T {}

            @inlinable
            public static func buildPartialBlock(accumulated: T, next: T) -> T {

                if T.from(accumulated) == .some(false) || T.from(next) == .some(false) {
                    return .false
                }
                if T.from(accumulated) == nil || T.from(next) == nil {
                    return .unknown
                }
                return .true
            }

            @inlinable
            public static func buildBlock() -> T {
                .true
            }

            @inlinable
            public static func buildOptional(_ component: T?) -> T {
                component ?? .true
            }

            @inlinable
            public static func buildEither(first: T) -> T {
                first
            }

            @inlinable
            public static func buildEither(second: T) -> T {
                second
            }

            @inlinable
            public static func buildArray(_ components: [T]) -> T {
                var hasUnknown = false
                for component in components {
                    if T.from(component) == .some(false) {
                        return .false
                    }
                    if T.from(component) == nil {
                        hasUnknown = true
                    }
                }
                return hasUnknown ? .unknown : .true
            }

            @inlinable
            public static func buildLimitedAvailability(_ component: T) -> T {
                component
            }
        }

        @resultBuilder
        public enum `Any` {

            @inlinable
            public static func buildExpression(_ expression: T) -> T {
                expression
            }

            @inlinable
            public static func buildExpression(_ expression: Bool) -> T {
                T(expression)
            }

            @inlinable
            public static func buildPartialBlock(first: T) -> T {
                first
            }

            @inlinable
            public static func buildPartialBlock(first: Void) -> T {
                .false
            }

            @inlinable
            public static func buildPartialBlock(first: Never) -> T {}

            @inlinable
            public static func buildPartialBlock(accumulated: T, next: T) -> T {

                if T.from(accumulated) == .some(true) || T.from(next) == .some(true) {
                    return .true
                }
                if T.from(accumulated) == nil || T.from(next) == nil {
                    return .unknown
                }
                return .false
            }

            @inlinable
            public static func buildBlock() -> T {
                .false
            }

            @inlinable
            public static func buildOptional(_ component: T?) -> T {
                component ?? .false
            }

            @inlinable
            public static func buildEither(first: T) -> T {
                first
            }

            @inlinable
            public static func buildEither(second: T) -> T {
                second
            }

            @inlinable
            public static func buildArray(_ components: [T]) -> T {
                var hasUnknown = false
                for component in components {
                    if T.from(component) == .some(true) {
                        return .true
                    }
                    if T.from(component) == nil {
                        hasUnknown = true
                    }
                }
                return hasUnknown ? .unknown : .false
            }

            @inlinable
            public static func buildLimitedAvailability(_ component: T) -> T {
                component
            }
        }

        @resultBuilder
        public enum None {

            @inlinable
            public static func buildExpression(_ expression: T) -> T {
                expression
            }

            @inlinable
            public static func buildExpression(_ expression: Bool) -> T {
                T(expression)
            }

            @inlinable
            public static func buildPartialBlock(first: T) -> T {
                first
            }

            @inlinable
            public static func buildPartialBlock(first: Void) -> T {
                .false
            }

            @inlinable
            public static func buildPartialBlock(first: Never) -> T {}

            @inlinable
            public static func buildPartialBlock(accumulated: T, next: T) -> T {

                if T.from(accumulated) == .some(true) || T.from(next) == .some(true) {
                    return .true
                }
                if T.from(accumulated) == nil || T.from(next) == nil {
                    return .unknown
                }
                return .false
            }

            @inlinable
            public static func buildBlock() -> T {
                .false
            }

            @inlinable
            public static func buildOptional(_ component: T?) -> T {
                component ?? .false
            }

            @inlinable
            public static func buildEither(first: T) -> T {
                first
            }

            @inlinable
            public static func buildEither(second: T) -> T {
                second
            }

            @inlinable
            public static func buildArray(_ components: [T]) -> T {
                var hasUnknown = false
                for component in components {
                    if T.from(component) == .some(true) {
                        return .true
                    }
                    if T.from(component) == nil {
                        hasUnknown = true
                    }
                }
                return hasUnknown ? .unknown : .false
            }

            @inlinable
            public static func buildLimitedAvailability(_ component: T) -> T {
                component
            }

            @inlinable
            public static func buildFinalResult(_ component: T) -> T {

                switch T.from(component) {
                case true: return .false
                case false: return .true
                case nil: return .unknown
                }
            }
        }
    }
}

extension Logic.Ternary {

    @inlinable
    public static func all<T: `Protocol`>(@Builder<T>.All _ builder: () -> T) -> T {
        builder()
    }

    @inlinable
    public static func any<T: `Protocol`>(@Builder<T>.`Any` _ builder: () -> T) -> T {
        builder()
    }

    @inlinable
    public static func none<T: `Protocol`>(@Builder<T>.None _ builder: () -> T) -> T {
        builder()
    }
}
