//
//  Callback.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 09/07/2019.
//

import Foundation

/// Protocol that can be used where we don't care about implementation details
public protocol MockExecutable {
    func execute()
}

/// A helper class to encapsulate callbacks in hand rolled mocks
/// P is the type of the parameters passed to the callback
/// R is the type of the callback's return value (this will usually be Void)
public class Callback<P, R>: MockExecutable {
    // Configurable
    fileprivate var chainedCallbackParams: [P] = []
    public var callbackParams: P
    public var callback: ((P) -> R)?

    // Record
    fileprivate var _returnedToCallback: R?

    public init(defaultCallbackParams: P) {
        callbackParams = defaultCallbackParams
    }

    public func firstCallbackWith(params: P) -> Callback<P, R> {
        chainedCallbackParams = []
        return thenCallbackWith(params: params)
    }

    public func thenCallbackWith(params: P) -> Callback<P, R> {
        chainedCallbackParams.append(params)
        return self
    }
}

// MARK: - Executions
public extension Callback {
    /// Execute the function
    func execute() {
        let params: P
        if chainedCallbackParams.isEmpty {
            params = callbackParams
        } else {
            params = chainedCallbackParams.removeFirst()
        }
        _returnedToCallback = callback?(params)
    }
}

// MARK: - Interrogated by the user after execution
public extension Callback {
    var returnedToCallback: R? {
        return _returnedToCallback
    }
}
