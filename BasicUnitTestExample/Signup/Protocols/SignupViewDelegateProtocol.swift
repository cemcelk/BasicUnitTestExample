//
//  SignupViewDelegateProtocol.swift
//  BasicUnitTestExample
//
//  Created by Cem Celik on 10.09.2021.
//

import Foundation

protocol SignupViewDelegateProtocol: AnyObject {
    func successfullSignup()
    func errorHandler(error: SignupError)
}
