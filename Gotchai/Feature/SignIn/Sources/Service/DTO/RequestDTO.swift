//
//  RequestDTO.swift
//  SignIn
//
//  Created by koreamango on 8/9/25.
//

public struct AppleSignInRequestDTO: Equatable, Encodable {
    public let idToken: String

    public init(idToken: String) {
        self.idToken = idToken
    }
}

public struct KakaoSignInRequestDTO: Equatable, Encodable {
    public let accessToken: String

    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
