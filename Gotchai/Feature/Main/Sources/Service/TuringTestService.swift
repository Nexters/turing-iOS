//
//  TuringTestService.swift
//  Main
//
//  Created by 가은 on 8/13/25.
//

import Combine
import CustomNetwork

struct TuringTestService {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getTestList(_ target: TuringTestAPI) -> AnyPublisher<[TuringTestCard], Error> {
        networkClient
            .request(target, type: TuringTestListResponseDTO.self)
            .handleEvents(receiveOutput: { response in
                print("✅ 테스트 리스트 응답: \(response)")
            })
            .map { dto in
                let convertedData = dto.list.map { itemDto in
                    TuringTestCard(
                        id: itemDto.id,
                        imageURL: itemDto.iconImage,
                        title: itemDto.title,
                        subtitle: itemDto.subTitle,
                        isSolved: itemDto.isSolved
                    )
                }
                return convertedData
            }
            .eraseToAnyPublisher()
    }
    
    func getTuringTest(_ target: TuringTestAPI) -> AnyPublisher<TuringTest, Error> {
        networkClient
            .request(target, type: TuringTestItemDTO.self)
            .map { dto in
                TuringTest(
                    id: dto.id,
                    iconURL: dto.iconImage,
                    imageURL: dto.coverImage,
                    title: dto.title,
                    subtitle: dto.subTitle,
                    explanation: dto.description,
                    backgroundImageURL: dto.backgroundImage)
            }
            .eraseToAnyPublisher()
    }
}
