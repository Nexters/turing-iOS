//
//  AuthError.swift
//  Auth
//
//  Created by 가은 on 7/23/25.
//

import Foundation

public enum AuthError: Error {
    case canceled
    case serverError(String)
    case appleLoginFailed
}

extension AuthError {
    init(_ error: Error) {
        self = (error as? AuthError) ?? .serverError(error.localizedDescription)
    }
}
