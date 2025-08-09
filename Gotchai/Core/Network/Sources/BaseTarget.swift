//
//  BaseTarget.swift
//  Core/Network
//
//  Created by koreamango on 8/9/25.
//

import Moya
import Foundation

public protocol BaseTarget: TargetType {}

public extension BaseTarget {
    var baseURL: URL {
        let scheme = Bundle.main.object(forInfoDictionaryKey: "BASE_SCHEME") as? String ?? "https"
        let host   = Bundle.main.object(forInfoDictionaryKey: "BASE_HOST") as? String ?? ""

        var comp = URLComponents()
        comp.scheme = scheme
        comp.host = host
        // comp.port = port
        guard let url = comp.url else {
            preconditionFailure("❌ Invalid BASE URL. scheme=\(scheme), host=\(host)")
        }
        return url
    }


    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        Data()
    }
}
