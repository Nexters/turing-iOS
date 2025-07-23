//
//  AuthFeature.swift
//  Auth
//
//  Created by 가은 on 7/20/25.
//

import ComposableArchitecture

@Reducer
struct AuthFeature {
    
    @ObservableState
    struct State {
        var isLoggingIn: Bool = false
        var errorMessage: String?
    }
    
    enum Action {
        case loginButtonTapped(LoginType)
        case loginResponse(Result<User, AuthError>)
    }
    
    @Dependency(\.authClient) var authClient
    
    var body: some ReducerOf<Self> {
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
                return .none

            case let .loginResponse(.failure(error)):
                state.isLoggingIn = false
                state.errorMessage = error.localizedDescription
                return .none
            }
        }
    }
}

