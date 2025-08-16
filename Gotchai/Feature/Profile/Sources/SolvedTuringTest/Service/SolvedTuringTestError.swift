//
//  SolvedTuringTestError.swift
//  Profile
//
//  Created by koreamango on 8/16/25.
//

import Foundation

enum SolvedTuringTestError: LocalizedError {
    case server(status: Int)
    var errorDescription: String? {
        switch self {
        case .server(let code):
            return "SolvedTuringTest API failed (status: \(code))"
        }
    }
}
