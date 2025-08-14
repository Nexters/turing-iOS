//
//  QuizModel.swift
//  Main
//
//  Created by 가은 on 8/5/25.
//

import Foundation

public struct Quiz: Equatable {
    let id: Int
    let contents: String
    let answers: [Answer]
}

public struct Answer: Equatable {
    let id: Int
    let contents: String
}

public extension Quiz {
    static let dummy: Quiz = .init(id: 1, contents: "크리스마스 트리 꾸미기  중...\n“트리에 뭔가 허전한데, 뭘 더 달까?”", answers: [Answer(id: 1, contents: "별이 없네.\n트리는 역시 별을 달아야 완성이지!"),Answer(id: 2, contents: "음~ 반짝이랑 리본 살짝 감으면 확 살아날 것 같은데?")])
}

public struct AnswerPopUp: Equatable {
    let answer: String
    let status: QuizProgress
}

public struct ResultBadge {
    let imageURL: String
    let badgeName: String
    let description: String
    let tier: GradientTheme
    let correctCount: Int
}
