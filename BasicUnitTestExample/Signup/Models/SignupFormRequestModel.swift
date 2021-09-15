//
//  SignupFormRequestModel.swift
//  BasicUnitTestExample
//
//  Created by Cem Celik on 9.09.2021.
//

import Foundation

struct SignupFormRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
