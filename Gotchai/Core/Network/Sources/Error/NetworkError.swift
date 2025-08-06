//
//  NetworkError.swift
//  Network
//
//  Created by koreamango on 7/20/25.
//

enum NetworkError: Error {
    case statusCode(Int)
    case api(APIError)
}
