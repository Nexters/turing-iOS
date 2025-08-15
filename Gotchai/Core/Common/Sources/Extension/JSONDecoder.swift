//
//  Date.swift
//  Common
//
//  Created by koreamango on 8/15/25.
//

import Foundation

// MARK: - ISO8601(ns) Decoder (가변 소수점 자리수 대응)

public extension JSONDecoder {
    /// 서버가 `2025-08-15T07:29:20.845188519`처럼 나노초까지 주는 경우 대응
    static var iso8601NanoSeconds: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let raw = try container.decode(String.self)

            // 1) fractional 포함 시도
            if let d = ISO8601DateFormatter.withFractional.date(from: raw) {
                return d
            }
            // 2) fractional 없음 시도
            if let d = ISO8601DateFormatter.noFractional.date(from: raw) {
                return d
            }
            // 3) 소수점 자릿수 정규화(최대 6자리로 자르거나 패딩) 후 재시도
            if let dot = raw.firstIndex(of: ".") {
                // 타임존 시작 위치(Z / +hh:mm / -hh:mm)
                let tzStart = raw[dot...].firstIndex(where: { $0 == "Z" || $0 == "+" || $0 == "-" }) ?? raw.endIndex
                var frac = String(raw[raw.index(after: dot)..<tzStart])

                if frac.count > 6 { frac = String(frac.prefix(6)) }
                else if frac.count > 0, frac.count < 6 { frac = frac.padding(toLength: 6, withPad: "0", startingAt: 0) }

                let head = String(raw[..<dot])
                let tail = String(raw[tzStart...])
                let normalized = "\(head).\(frac)\(tail)"

                if let d = ISO8601DateFormatter.withFractional.date(from: normalized) {
                    return d
                }
            }

            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid ISO8601 date: \(raw)")
        }
        return decoder
    }
}

private extension ISO8601DateFormatter {
    static let withFractional: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        f.timeZone = TimeZone(secondsFromGMT: 0)
        return f
    }()

    static let noFractional: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime]
        f.timeZone = TimeZone(secondsFromGMT: 0)
        return f
    }()
}
