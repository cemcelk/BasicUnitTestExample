//
//  SignupPresenterProtocol.swift
//  BasicUnitTestExample
//
//  Created by Cem Celik on 10.09.2021.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
    init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol)
    func processUserSignup(formModel: SignupFormModel)
}
