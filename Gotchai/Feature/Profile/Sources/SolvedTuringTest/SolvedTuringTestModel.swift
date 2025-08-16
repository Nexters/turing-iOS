//
//  SolvedTuringTestModel.swift
//  Profile
//
//  Created by 가은 on 8/9/25.
//

import Foundation

public struct SolvedTuringTest: Equatable {
    let id: Int
    let title: String
    let iconURL: String
    let correctCount: Int
    let totalQuizCount: Int
    let percent: Int
}

extension SolvedTuringTest {
    init(dto: TuringTestDTO) {
        self.init(
            id: dto.id,
            title: dto.title,
            iconURL: dto.iconImage,
            correctCount: dto.correctAnswerCount,
            totalQuizCount: dto.totalQuizCount,
            percent: dto.correctAnswerRate
        )
    }
}
