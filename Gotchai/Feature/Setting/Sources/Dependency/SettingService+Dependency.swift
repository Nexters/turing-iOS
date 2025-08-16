//
//  SettingService+Dependency.swift
//  Setting
//
//  Created by koreamango on 8/15/25.
//

import TCA

extension SettingService: DependencyKey {
    public static let liveValue: SettingService = {
        SettingService(networkClient: DependencyValues.live.networkClient)
    }()
}

public extension DependencyValues {
    var settingService: SettingService {
        get { self[SettingService.self] }
        set { self[SettingService.self] = newValue }
    }
}
