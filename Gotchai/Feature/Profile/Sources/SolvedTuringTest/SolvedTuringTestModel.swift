//
//  SolvedTuringTestModel.swift
//  Profile
//
//  Created by 가은 on 8/9/25.
//

import Foundation

struct SolvedTuringTest {
    let id = UUID()
    let iconURL: String
    let title: String
    let correctCount: Int
    let totalQuizCount: Int
    let percent: Int
}

extension SolvedTuringTest {
    static let dummyList: [SolvedTuringTest] = (0..<10).map { index in
        SolvedTuringTest(iconURL: "", title: "Ai와 크리스마스 파티 \(index)", correctCount: 4, totalQuizCount: 7, percent: 50)
    }
}
