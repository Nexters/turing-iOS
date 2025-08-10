//
//  APIResponse.swift
//  Network
//
//  Created by koreamango on 8/7/25.
//

public struct APIResponse<T: Decodable>: Decodable {
  public let isSuccess: Bool
  public let status: Int
  public let data: T
  public let timestamp: String
}
