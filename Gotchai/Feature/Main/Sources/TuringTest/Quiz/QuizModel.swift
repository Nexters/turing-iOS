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
    let answers: [String]
}

public extension Quiz {
    static let dummy: Quiz = .init(id: 1, contents: "크리스마스 트리 꾸미기  중...\n“트리에 뭔가 허전한데, 뭘 더 달까?”", answers: ["별이 없네.\n트리는 역시 별을 달아야 완성이지!","음~ 반짝이랑 리본 살짝 감으면 확 살아날 것 같은데?"])
}
