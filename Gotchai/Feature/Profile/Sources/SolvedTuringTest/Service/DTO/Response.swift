//
//  Response.swift
//  Profile
//
//  Created by koreamango on 8/16/25.
//

import Foundation

struct TuringTestListResponseDTO: Decodable, Equatable, Sendable {
    let list: [TuringTestDTO]
}

struct TuringTestDTO: Decodable, Equatable, Sendable {
    let id: Int
    let title: String
    let iconImage: String
    let correctAnswerRate: Int
    let totalQuizCount: Int
    let correctAnswerCount: Int
    let solvedAt: String
}
