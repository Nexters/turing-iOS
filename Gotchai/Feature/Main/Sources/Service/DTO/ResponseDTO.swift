//
//  ResponseDTO.swift
//  Main
//
//  Created by 가은 on 8/13/25.
//

public struct TuringTestListResponseDTO: Decodable {
    let list: [TuringTestItemDTO]
}

public struct TuringTestItemDTO: Decodable {
    let id: Int
    let title: String
    let subTitle: String
    let description: String
    let prompt: String
    let backgroundImage: String
    let iconImage: String
    let coverImage: String
    let theme: String
    let isSolved: Bool
    let createdAt: String
}

public struct TuringTestStartResponseDTO: Decodable {
    let quizIds: [Int]
}

public struct SubmitTuringTestResponseDTO: Decodable {
    let answerCount: Int
    let badge: TuringTestBadgeDTO
}

public struct TuringTestBadgeDTO: Decodable {
    let id: Int
    let examId: Int
    let name: String
    let description: String
    let image: String
    let tier: String
    let createdAt: String
}

// 퀴즈 GET
public struct GetQuizDTO: Decodable {
    let id: Int
    let contents: String
    let quizPicks: [AnswerCardDTO]
    let createdAt: String
}

public struct AnswerCardDTO: Decodable {
    let id: Int
    let contents: String
}

// 퀴즈 채점
public struct GradeQuizResponseDTO: Decodable {
    let contents: String
    let isAnswer: Bool
    let isTimeout: Bool
}
