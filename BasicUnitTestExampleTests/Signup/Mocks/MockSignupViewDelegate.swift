//
//  MockSignupViewDelegate.swift
//  BasicUnitTestExampleTests
//
//  Created by Cem Celik on 10.09.2021.
//

import Foundation
import XCTest
@testable import BasicUnitTestExample

class MockSignupViewDelegate: SignupViewDelegateProtocol {
    var expectation: XCTestExpectation?
    var successfullSignupCounter = 0
    var errorHandlerCounter = 0
    var signupError: SignupError?

    func successfullSignup() {
        successfullSignupCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignupError) {
        signupError = error
        errorHandlerCounter += 1
        expectation?.fulfill()
    }
}
