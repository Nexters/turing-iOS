//
//  ResponseDTO.swift
//  SignIn
//
//  Created by koreamango on 8/9/25.
//

public struct SignInResponseDTO: Equatable, Decodable {
    public let accessToken: String
    public let refreshToken: String

    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
