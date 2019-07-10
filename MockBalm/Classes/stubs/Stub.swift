//
//  Stub.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 09/07/2019.
//

import Foundation

/// A list of arbitrary callback labels to make it easy to specify the callback that should be invoked
public enum CallbackType {
    case success
    case error
}

/// A helper class to speed up hand-cranking mocks for testing
///
/// R is the return type of the method to stub
///     - Use 'Void' if there is no return type
/// P is the type of the parameters that the stubbed method is called with
///     - Use a tuple or typealias if there are multiple parameters
public class Stub<R, P> {

    // Configurable
    private var chainedReturns: [() -> R] = []
    private var finallyReturn: (() -> R)
    private var callbackType: CallbackType? = .success
    public var throwVal: Error?
    private var callbacks: [CallbackType: MockExecutable] = [:]

    // Record
    private var _callCount = 0
    private var _calledWithHistory: [P] = []

    public init(returnValue: @escaping @autoclosure () -> R) {
        finallyReturn = returnValue
    }
}

// MARK: - Initialisation
public extension Stub {
    /// Set a value to return first.
    /// NB if return values have already been set with firstReturn / thenReturn, these
    /// will be cleared by calling this function
    ///
    /// - Parameter retval: the retval to return
    /// - Returns: the stub, so other setup can be chained
    func firstReturn(_ returnValue: @escaping @autoclosure () -> R) -> Stub<R, P> {
        return firstReturn(returnValueGenerator: returnValue)
    }

    /// Set a closure to generate on demand a value to return first.
    /// NB if return values have already been set with firstReturn / thenReturn, these
    /// will be cleared by calling this function
    ///
    /// - Parameter retvalGenerator: the closure to generate the retval
    /// - Returns: the stub, so other setup can be chained
    func firstReturn(returnValueGenerator: @escaping () -> R) -> Stub<R, P> {
        chainedReturns = []
        return thenReturn(returnValueGenerator: returnValueGenerator)
    }

    /// Set a value to return next.
    ///
    /// - Parameter retval: the retval to return
    /// - Returns: the stub, so other setup can be chained
    func thenReturn(_ retval: @escaping @autoclosure () -> R) -> Stub<R, P> {
        return thenReturn(returnValueGenerator: retval)
    }

    /// Set a closure to generate on demand a value to return next.
    ///
    /// - Parameter retvalGenerator: the closure to generate the retval
    /// - Returns: the stub, so other setup can be chained
    func thenReturn(returnValueGenerator: @escaping () -> R) -> Stub<R, P> {
        chainedReturns.append(returnValueGenerator)
        return self
    }

    /// Set a value to always return (NB this is effectively the same as setting retval directly)
    ///
    /// - Parameter retval: the retval to return
    /// - Returns: the stub, so other setup can be chained
    func finallyAlwaysReturn(_ retval: @escaping @autoclosure () -> R) -> Stub<R, P> {
        return finallyAlwaysReturn(returnValueGenerator: retval)
    }

    /// Set a closure to generate on demand a value to always return
    /// (NB this is effectively the same as setting retval directly, except it can be used for generators rather
    /// than just return values)
    ///
    /// - Parameter retvalGenerator: the closure to generate the retval
    /// - Returns: the stub, so other setup can be chained
    func finallyAlwaysReturn(returnValueGenerator: @escaping () -> R) -> Stub<R, P> {
        finallyReturn = returnValueGenerator
        return self
    }

    /// Set the callback type for the stub. This will look up the callback set for that type and invoke it
    ///
    /// - Parameter callbackType: the type of callback to invoke
    /// - Returns: the stub, so other setup can be chained
    func callbackWith(callbackType: CallbackType) -> Stub<R, P> {
        self.callbackType = callbackType
        return self
    }

    /// Add a callback to invoke for a given callback type
    ///
    /// - Parameters:
    ///   - callback: the callback
    ///   - callbackType: the type of the callback
    /// - Returns: the stub, so other setup can be chained
    func addCallback(callback: MockExecutable, for callbackType: CallbackType) -> Stub<R, P> {
        callbacks[callbackType] = callback
        return self
    }
}

// MARK: - Execution
public extension Stub {
    /// Called in a mocked method that throws an exception
    ///
    /// - Parameter params: the parameters that the method was called with
    /// - Returns: the return value specified
    /// - Throws: the throwable specified
    func executeAndThrow(params: P) throws -> R {
        recordExecution(params: params)

        // Throw an error if there was one
        if let error = throwVal {
            throw error
        }

        invokeCallback()
        return getRetval()
    }

    /// Called in the mocked method.
    /// Invoke a callback if one is specified, then return the retval.
    ///
    /// - Parameter params: the params to invoke the method with
    /// - Returns: the retval that has been specified
    func executeWithoutThrowable(params: P) -> R {
        recordExecution(params: params)
        invokeCallback()
        return getRetval()
    }
}

// MARK: - Interrogated by the user after execution
public extension Stub {
    /// Interrogate to find how many times this stub was called
    var callCount: Int {
        return _callCount
    }

    /// Interrogate to find the last set of parameters that the method was called with
    var calledWith: P? {
        return calledWithHistory.last
    }

    /// Interrogate to find all parameters that the method was called with
    var calledWithHistory: [P] {
        return _calledWithHistory
    }
}

// MARK: - Helper functions
private extension Stub {
    /// Get the correct retval for the stub to return
    ///
    /// - Returns: the retval
    func getRetval() -> R {
        let retvalToUse: R

        // Chained returns
        if !chainedReturns.isEmpty {
            let retvalGenerator = chainedReturns.removeFirst()
            retvalToUse = retvalGenerator()
        } else {
            retvalToUse = finallyReturn()
        }
        return retvalToUse
    }

    /// Called when anything is executed.
    ///
    /// Increment the call count and record the parameters
    ///
    /// - Parameter params: the parameters passed to the method
    private func recordExecution(params: P) {
        _callCount += 1
        _calledWithHistory.append(params)
    }

    /// Invoke the callback if required
    private func invokeCallback() {
        if let callbackType = callbackType {
            callbacks[callbackType]?.execute()
        }
    }
}
