//
//  SignupWebServiceTests.swift
//  BasicUnitTestExampleTests
//
//  Created by Cem Celik on 9.09.2021.
//

import XCTest
@testable import BasicUnitTestExample

class SignupWebServiceTests: XCTestCase {
    var sut: SignupWebService!
    var signupFormRequestModel: SignupFormRequestModel!

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlString: SignupConstants.signupURLString, urlSession: urlSession)
        signupFormRequestModel = SignupFormRequestModel(
            firstName: "Cem",
            lastName: "Celik",
            email: "test@test.com",
            password: "12345678")
    }

    override func tearDownWithError() throws {
        sut = nil
        signupFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        // Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
            // Assert
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        // Arrange
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)

        let expectation = self.expectation(description: "Signup() method expectation for a response that contains a different JSON structure")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
            // Assert
            XCTAssertNil(signupResponseModel, "The response model for a request containing unknown JSON response, should have been nil")
            XCTAssertEqual(error, SignupError.invalidResponseModel, "The signup() method did not return expected error")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenEmptyURLStringProvided_ReturnsError() {
        // Arrange
        let expectation = self.expectation(description: "An empty request URL string expectation")
        sut = SignupWebService(urlString: "")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { signupResponseModel, error in
            // Assert
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "The signup() method did not return an expected error for an invalidRequestURLString error")
            XCTAssertNil(signupResponseModel, "When an invalidRequestURLString takes place, the response model must be nil")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        // Arrange
        let expectation = self.expectation(description: "A failed Request expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
        // Act
        sut.signup(withForm: signupFormRequestModel) { signupResponseModel, error in
            // Assert
            XCTAssertEqual(error, SignupError.failedRequest(description: errorDescription), "The signup() method did not return an expecter error for the Failed Request")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
}
