//
//  SolvedTuringTestModel.swift
//  Profile
//
//  Created by 가은 on 8/9/25.
//

import Foundation

struct SolvedTuringTest: Equatable {
    let id: Int
    let iconURL: String
    let title: String
    let correctCount: Int
    let totalQuizCount: Int
    let percent: Int
}

extension SolvedTuringTest {
    init(dto: TuringTestDTO) {
        self.init(
            id: dto.id,
            iconURL: dto.iconImage.absoluteString,
            title: dto.title,
            correctCount: 0,         // 서버에서 값 없으니 기본값
            totalQuizCount: 0,       // 서버에서 값 없으니 기본값
            percent: 0               // 서버에서 값 없으니 기본값
        )
    }
}

extension SolvedTuringTest {
    static let dummyList: [SolvedTuringTest] = (0..<10).map { index in
        SolvedTuringTest(
            id: index ,
            iconURL: "",
            title: "Ai와 크리스마스 파티 \(index)",
            correctCount: 4,
            totalQuizCount: 7,
            percent: 50
        )
    }
}
