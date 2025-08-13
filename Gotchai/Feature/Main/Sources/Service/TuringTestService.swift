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
    
    func getTestList(_ target: TuringTestAPI) -> AnyPublisher<TuringTestListResponseDTO, Error> {
        networkClient
            .request(target, type: TuringTestListResponseDTO.self)
            .handleEvents(receiveOutput: { response in
                print("✅ 테스트 리스트 응답: \(response)")
            })
            .eraseToAnyPublisher()
    }
}
