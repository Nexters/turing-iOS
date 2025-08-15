//
//  RequestDTO.swift
//  Main
//
//  Created by 가은 on 8/13/25.
//

public struct GradeQuizRequestDTO: Encodable {
    let quizPickId: Int
    let isTimeout: Bool
}
