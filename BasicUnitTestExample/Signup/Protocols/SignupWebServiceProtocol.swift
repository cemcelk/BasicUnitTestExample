//
//  SignupWebServiceProtocol.swift
//  BasicUnitTestExample
//
//  Created by Cem Celik on 10.09.2021.
//

import Foundation

protocol SignupWebServiceProtocol {
    func signup(withForm formModel: SignupFormRequestModel,
                completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void)
}
