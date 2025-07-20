//
//  NetworkLoggerPlugin.swift
//  Network
//
//  Created by koreamango on 7/20/25.
//

import Moya

/// 요청, 응답 이후 Log를 남기는 Plugin
final class NetworkLoggerPlugin: PluginType {
  public init() {}

  func willSend(_ request: RequestType, target: TargetType) {
    print("➡️ 요청: \(request.request?.url?.absoluteString ?? "")")
  }

  func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
    switch result {
    case .success(let response):
        print("✅ 응답: \(response.statusCode), \(String(data: response.data, encoding: .utf8) ?? "")")
    case .failure(let error):
        print("❌ 에러: \(error)")
    }
  }
}
