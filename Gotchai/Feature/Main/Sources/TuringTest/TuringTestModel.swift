//
//  TuringTestModel.swift
//  Main
//
//  Created by 가은 on 8/5/25.
//

import Foundation

public struct TuringTestCard {
    let id: Int
    let imageURL: String
    let title: String
    let subtitle: String
}

public extension TuringTestCard {
    static let dummyList: [TuringTestCard] = [
        .init(id: 1, imageURL: "", title: "Ai와 크리스마스 파티", subtitle: "산타는 누구야?"),
        .init(id: 2, imageURL: "", title: "소개팅 톡 감별 테스트", subtitle: "어떤 대답이 진심일까?"),
        .init(id: 3, imageURL: "", title: "전학생과의 첫 인사", subtitle: "누가 진짜 전학생이야?"),
        .init(id: 4, imageURL: "", title: "Ai와 크리스마스 파티", subtitle: "산타는 누구야?"),
        .init(id: 5, imageURL: "", title: "소개팅 톡 감별 테스트", subtitle: "어떤 대답이 진심일까?"),
        .init(id: 6, imageURL: "", title: "전학생과의 첫 인사", subtitle: "누가 진짜 전학생이야?")
    ]
}

public struct TuringTest {
    let id: Int
    let iconURL: String
    let imageURL: String
    let title: String
    let subtitle: String
    let explanation: String
    let backgroundImageURL: String
}

extension TuringTest {
    static let dummy: TuringTest = .init(
        id: 1,
        iconURL: "",
        imageURL: "",
        title: "Ai와 크리스마스 파티",
        subtitle: "산타는 누구야?",
        explanation: "크리스마스 이브 밤,\n친구들과의 랜선 파티에 초대된 당신.\n모두가 산타 모자를 쓰고 등장했지만…\n그 중 하나는 사람처럼 말하는 AI?!\n이제 당신의 임무는\n대화 속에서 AI의 말투를 간파하는 것!\n과연 진짜 친구와 AI 산타,\n구분할 수 있을까요?",
        backgroundImageURL: ""
    )
}
