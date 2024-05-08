//
//  GraphQLHelper.swift
//  amoring
//
//  Created by Sergey Li on 5/8/24.
//

import ApolloAPI

public struct GraphQLHelper {

    @available(*, unavailable)
    init() {}

    /// Wraps a value inside a `GraphQLNullable` object. Use when a GraphQL property expects
    /// a `GraphQLNullable` type.
    ///
    /// - parameter value: The object to wrap
    ///
    /// - returns: a `GraphQLNullable` object
    static public func graphQLNullableFrom<T>(_ value: T?) -> GraphQLNullable<T> {
        if let val = value {
            return .some(val)
        }

        return .none
    }
}
