//
//  MockSignupPresenter.swift
//  BasicUnitTestExampleTests
//
//  Created by Cem Celik on 10.09.2021.
//

import Foundation
@testable import BasicUnitTestExample

class MockSignupPresenter: SignupPresenterProtocol {
    var processUserSignupCalled: Bool = false

    required init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol) {
        
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        processUserSignupCalled = true
    }
}
