//
//  Dependency.swift
//  Network
//
//  Created by koreamango on 8/9/25.
//


import TCA
import Moya

extension MoyaAPIClient: DependencyKey {
    public static let liveValue: NetworkClient = {
        let provider = MoyaProvider<MultiTarget>(plugins: [AuthPlugin()])
        return MoyaAPIClient(provider: provider)
    }()
}

public extension DependencyValues {
    var networkClient: NetworkClient {
        get { self[MoyaAPIClient.self] }
        set { self[MoyaAPIClient.self] = newValue }
    }
}
