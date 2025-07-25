//
//  AuthFeature.swift
//  Auth
//
//  Created by 가은 on 7/20/25.
//

import ComposableArchitecture

@Reducer
public struct AuthFeature {
    
    @ObservableState
    public struct State {
        public init() { }
        var isLoggingIn: Bool = false
        var errorMessage: String?
        var user: User?
    }
    
    public enum Action {
        case loginButtonTapped(LoginType)
        case loginResponse(Result<User, AuthError>)
    }
    
    public init() { }
    
    @Dependency(\.authClient) var authClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .loginButtonTapped(type):
                state.isLoggingIn = true
                return .run { send in
                    let result = await Result { try await authClient.login(type) }
                        .mapError(AuthError.init)
                    await send(.loginResponse(result))
                }
                
            case let .loginResponse(.success(user)):
                state.isLoggingIn = false
                state.user = user
                return .none

            case let .loginResponse(.failure(error)):
                state.isLoggingIn = false
                state.errorMessage = error.localizedDescription
                return .none
            }
        }
    }
}

