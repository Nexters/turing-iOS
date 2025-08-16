//
//  AuthError.swift
//  Auth
//
//  Created by koreamango on 8/14/25.
//

import Foundation

public enum AuthError: Error, Sendable, LocalizedError {
    case noActiveProvider
    case signInFailed(reason: String)
    case signOutFailed(reason: String)
    case deleteUserFailed(reason: String)
    case finishedWithoutValue

    public var errorDescription: String? {
        switch self {
        case .noActiveProvider:
            return "활성화된 인증 공급자가 없습니다."
        case .signInFailed(let reason):
            return "로그인에 실패했습니다: \(reason)"
        case .signOutFailed(let reason):
            return "로그아웃에 실패했습니다: \(reason)"
        case .deleteUserFailed(let reason):
            return "사용자 삭제에 실패했습니다: \(reason)"
        case .finishedWithoutValue:
            return "응답 없이 완료되었습니다."
        }
    }
}
