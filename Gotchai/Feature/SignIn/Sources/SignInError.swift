//
//  AuthError.swift
//  Auth
//
//  Created by 가은 on 7/23/25.
//

import Foundation

public enum SignInError: Error {
    case canceled
    case serverError(String)
    case appleLoginFailed
}

extension SignInError {
    init(_ error: Error) {
        self = (error as? SignInError) ?? .serverError(error.localizedDescription)
    }
}
