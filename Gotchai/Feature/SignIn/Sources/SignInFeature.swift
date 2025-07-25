//
//  AuthFeature.swift
//  Auth
//
//  Created by 가은 on 7/20/25.
//

import ComposableArchitecture

@Reducer
public struct SignInFeature {

    @ObservableState
    public struct State {
        public init() { }
        var isLoggingIn: Bool = false
        var errorMessage: String?
        var user: User?
    }
    
    public enum Action {
        case signInButtonTapped(SignInType)
        case signInResponse(Result<User, SignInError>)
    }
    
    public init() { }
    
    @Dependency(\.signInClient) var signInClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .signInButtonTapped(type):
                state.isLoggingIn = true
                return .run { send in
                    let result = await Result { try await signInClient.signIn(type) }
                        .mapError(SignInError.init)
                    await send(.signInResponse(result))
                }
                
            case let .signInResponse(.success(user)):
                state.isLoggingIn = false
                state.user = user
                return .none

            case let .signInResponse(.failure(error)):
                state.isLoggingIn = false
                state.errorMessage = error.localizedDescription
                return .none
            }
        }
    }
}

