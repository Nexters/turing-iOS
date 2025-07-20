//
//  KeychainTokenProvider.swift
//  Key
//
//  Created by koreamango on 7/20/25.
//

import Foundation
import Security

public final class KeychainTokenProvider: TokenProvider {
    public static let shared = KeychainTokenStorage()

    private let service = "com.gotchai.token"
    private let account = "accessToken"

    private init() {}

    public var accessToken: String? {
        get {
            guard let data = readKeychain() else { return nil }
            return String(data: data, encoding: .utf8)
        }
        set {
            if let newToken = newValue {
                saveKeychain(data: Data(newToken.utf8))
            } else {
                deleteKeychain()
            }
        }
    }

    private func readKeychain() -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ]

        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }

    private func saveKeychain(data: Data) {
        deleteKeychain()

        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecValueData: data
        ]

        SecItemAdd(query as CFDictionary, nil)
    }

    private func deleteKeychain() {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}
