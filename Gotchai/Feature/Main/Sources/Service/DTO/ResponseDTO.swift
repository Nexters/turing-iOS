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
    let createdAt: String
}
