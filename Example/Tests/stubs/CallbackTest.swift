//
//  CallbackTest.swift
//  appstarter-pod-ios_Tests
//
//  Created by Gabrielle Earnshaw on 09/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import MockBalm

class CallbackTest: XCTestCase {
    // No code
}

extension CallbackTest {
    func test_itShouldCallback_whenExecuted() {
        // given
        let callback = Callback<Bool, Void>(defaultCallbackParams: false)

        let expectation = self.expectation(description: "Waiting for callback")
        callback.callback = { _ in
            expectation.fulfill()
        }

        // when
        callback.execute()

        // then
        waitForExpectations(timeout: 1) { (_) in
            // Do nothing
        }
    }

    func test_itShouldCallback_withDefaultParams_whenNoOtherParamsAreSet() {
        // given
        let expectedCallbackParams = "Gorgonzola"
        let callback = Callback<String, Void>(defaultCallbackParams: expectedCallbackParams)

        let expectation = self.expectation(description: "Waiting for callback")
        var actual: String?
        callback.callback = { params in
            actual = params
            expectation.fulfill()
        }

        // when
        callback.execute()

        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertEqual(actual, expectedCallbackParams)
        }
    }

    func test_itShouldCallback_withOverriddenParams_whenFirstCallbackParamsAreSet() {
        // given
        let defaultCallbackParams = "Gorgonzola"
        let expectedCallbackParams = "dairy milk"
        let callback = Callback<String, Void>(defaultCallbackParams: defaultCallbackParams)


        let expectation = self.expectation(description: "Waiting for callback")
        var actual: String?
        callback.callback = { params in
            actual = params
            expectation.fulfill()
        }

        // when
        _ = callback.firstCallbackWith(params: expectedCallbackParams)
        callback.execute()

        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertEqual(actual, expectedCallbackParams)
        }
    }

    func test_itShouldCallback_withOverriddenParams_whenThenCallbackParamsAreSet() {
        // given
        let defaultCallbackParams = "Gorgonzola"
        let expectedCallbackParams = "dairy milk"
        let callback = Callback<String, Void>(defaultCallbackParams: defaultCallbackParams)


        let expectation = self.expectation(description: "Waiting for callback")
        var actual: String?
        callback.callback = { params in
            actual = params
            expectation.fulfill()
        }

        // when
        _ = callback.thenCallbackWith(params: expectedCallbackParams)
        callback.execute()

        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertEqual(actual, expectedCallbackParams)
        }
    }

    func test_itShouldCallback_withDefaultParams_whenAllOverriddenParamsHaveBeenCalled() {
        // given
        let defaultCallbackParams = 354
        let callback = Callback<Int, Void>(defaultCallbackParams: defaultCallbackParams)

        let numberOfTimesToExecute = 3

        let expectation = self.expectation(description: "Waiting for callback")
        var actual: Int?
        var count = 0
        callback.callback = { params in
            count += 1
            if count >= numberOfTimesToExecute {
                actual = params
                expectation.fulfill()
            }
        }

        // when
        _ = callback.firstCallbackWith(params: 1)
            .thenCallbackWith(params: 2)

        // Execute the callback the required number of times
        (1...numberOfTimesToExecute).forEach { (_) in
            callback.execute()
        }

        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertEqual(actual, defaultCallbackParams)
        }
    }
}
