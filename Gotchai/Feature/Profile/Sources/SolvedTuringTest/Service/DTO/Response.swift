//
//  Response.swift
//  Profile
//
//  Created by koreamango on 8/16/25.
//

import Foundation

public struct TuringTestListResponseDTO: Decodable, Equatable, Sendable {
    public let isSuccess: Bool
    public let status: Int
    public let data: DataDTO
    public let timestamp: Date

    public struct DataDTO: Decodable, Equatable, Sendable {
        public let list: [TuringTestDTO]
    }
}

public struct TuringTestDTO: Decodable, Equatable, Sendable {
    public let id: Int
    public let title: String
    public let subTitle: String
    public let description: String
    public let prompt: String
    public let backgroundImage: URL
    public let iconImage: URL
    public let coverImage: URL
    public let theme: String
    public let isSolved: Bool
    public let createdAt: Date
}
