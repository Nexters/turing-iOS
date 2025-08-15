//
//  SolvedTuringTestService+Dependency.swift
//  Profile
//
//  Created by koreamango on 8/16/25.
//

import TCA

extension SolvedTuringTestService: DependencyKey {
    public static let liveValue: SolvedTuringTestService = {
        SolvedTuringTestService(networkClient: DependencyValues.live.networkClient)
    }()
}

public extension DependencyValues {
    var solvedTuringTestService: SolvedTuringTestService {
        get { self[SolvedTuringTestService.self] }
        set { self[SolvedTuringTestService.self] = newValue }
    }
}
