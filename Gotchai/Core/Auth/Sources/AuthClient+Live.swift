//
//  AuthClient+Live.swift
//  Auth
//
//  Created by 가은 on 7/23/25.
//

import TCA
import Combine

extension AuthClient: DependencyKey {
    public static func live(runtime: AuthRuntime = AuthRuntime()) -> AuthClient {
        AuthClient(
            signIn: { provider in
                provider.signIn()
                    .handleEvents(receiveOutput: { session in
                        runtime.set(session: session, provider: provider)
                    })
                    .eraseToAnyPublisher()
            },
            // signOut
            signOut: {
                Result { () -> AuthProvider in
                    guard let p = runtime.provider() else { throw AuthError.noActiveProvider }
                    return p
                }
                .publisher
                .flatMap { p in
                    p.signOut()
                        .handleEvents(receiveCompletion: { c in
                            if case .finished = c { runtime.clear() }
                        })
                }
                .eraseToAnyPublisher()
            },
            
            // deleteUser
            deleteUser: {
                Result { () -> AuthProvider in
                    guard let p = runtime.provider() else { throw AuthError.noActiveProvider }
                    return p
                }
                .publisher
                .flatMap { p in
                    p.deleteUser()
                        .handleEvents(receiveCompletion: { c in
                            if case .finished = c { runtime.clear() }
                        })
                }
                .eraseToAnyPublisher()
            }
        )
    }
    
    public static let liveValue: AuthClient = .live()
}


public extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
