//
//  SolvedTuringTestService.swift
//  Profile
//
//  Created by koreamango on 8/16/25.
//

import Foundation
import CustomNetwork
import TCA
import Combine

public struct SolvedTuringTestService {
    private let networkClient: NetworkClient

    public init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    public func fetchSolvedTuringTests() -> AnyPublisher<TuringTestListResponseDTO, Error> {
        networkClient
            .request(
                SolvedTuringTestAPI.fetchSolvedTuringTests ,
                type: TuringTestListResponseDTO.self
            )
            .handleEvents(receiveOutput: { response in
                print("✅ fetch Solved Turing Test 응답:", response)
            })
            .eraseToAnyPublisher()
    }
}
