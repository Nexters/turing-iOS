//
//  UserSession.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

public struct UserSession: Equatable, Sendable {
  public let id: String
  public let name: String
  public let token: String

  public init(id: String, name: String, token: String) {
    self.id = id
    self.name = name
    self.token = token
  }
}
